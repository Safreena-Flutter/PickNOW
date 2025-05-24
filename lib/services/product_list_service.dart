import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:picknow/model/products/latest_product_model.dart';
import '../model/products/product_list_model.dart';

class ProductListService {
  Future<ProductResponse> getProductsByNestedCategory({
    required String categoryId,
  }) async {
    try {
      final url = 'https://backmern.picknow.in/api/products/nested-subcategory/$categoryId';
      debugPrint('Fetching products from: $url');
      
      final response = await http.get(Uri.parse(url));
      debugPrint('Response status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final productResponse = ProductResponse.fromJson(jsonData);
        
        // Fetch variant details for each product
        for (var product in productResponse.products) {
          if (product.variants.isNotEmpty) {
            final variantId = product.variants.first;
            final variantUrl = 'https://backmern.picknow.in/api/variant/$variantId';
            debugPrint('Fetching variant from: $variantUrl');
            
            try {
              final variantResponse = await http.get(Uri.parse(variantUrl));
              debugPrint('Variant response status: ${variantResponse.statusCode}');
              debugPrint('Variant response body: ${variantResponse.body}');
              
              if (variantResponse.statusCode == 200) {
                final variantData = json.decode(variantResponse.body);
                if (variantData['success'] == true && variantData['variant'] != null) {
                  product.variantDetails = VariantDetails.fromJson(variantData['variant']);
                  debugPrint('Successfully added variant details for product: ${product.pName}');
                } else {
                  debugPrint('Variant data is null or success is false for product: ${product.pName}');
                }
              }
            } catch (e) {
              debugPrint('Error fetching variant details for product ${product.pName}: $e');
            }
          } else {
            debugPrint('No variants found for product: ${product.pName}');
          }
        }
        
        return productResponse;
      } else {
        throw Exception('Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error in getProductsByNestedCategory: $e');
      return ProductResponse(
        products: [],
        success: false,
      );
    }
  }

  Future<ProductResponse> fetchProductsByCategory(String categoryName) async {
    final url = "https://backmern.picknow.in/api/category/$categoryName/products";
    debugPrint('Fetching products from: $url');

    try {
      final response = await http.get(Uri.parse(url));
      debugPrint('Response status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["success"] == true) {
          final productResponse = ProductResponse.fromJson(data);
          
          // Fetch variant details for each product
          for (var product in productResponse.products) {
            if (product.variants.isNotEmpty) {
              final variantId = product.variants.first;
              final variantUrl = 'https://backmern.picknow.in/api/variant/$variantId';
              debugPrint('Fetching variant from: $variantUrl');
              
              try {
                final variantResponse = await http.get(Uri.parse(variantUrl));
                debugPrint('Variant response status: ${variantResponse.statusCode}');
                debugPrint('Variant response body: ${variantResponse.body}');
                
                if (variantResponse.statusCode == 200) {
                  final variantData = json.decode(variantResponse.body);
                  if (variantData['success'] == true && variantData['variant'] != null) {
                    product.variantDetails = VariantDetails.fromJson(variantData['variant']);
                    debugPrint('Successfully added variant details for product: ${product.pName}');
                  } else {
                    debugPrint('Variant data is null or success is false for product: ${product.pName}');
                  }
                }
              } catch (e) {
                debugPrint('Error fetching variant details for product ${product.pName}: $e');
              }
            } else {
              debugPrint('No variants found for product: ${product.pName}');
            }
          }
          
          return productResponse;
        } else {
          throw Exception("Failed to load products: ${data['message'] ?? 'Unknown error'}");
        }
      } else {
        throw Exception("Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint('Error in fetchProductsByCategory: $e');
      throw Exception("Error: $e");
    }
  }
}
