import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:picknow/model/products/latest_product_model.dart';

import '../../model/products/product_list_model.dart';

class LatestProductService {
  Future<LatestProductResponse> fetchLatestProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://backmern.picknow.in/api/products/latest'),
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final latestProducts = LatestProductResponse.fromJson(jsonData);
        
        // Fetch variant details for each product
        for (var product in latestProducts.products) {
          if (product.variants.isNotEmpty) {
            try {
              final variantResponse = await http.get(
                Uri.parse('https://backmern.picknow.in/api/variant/${product.variants.first}'),
              );
              
              if (variantResponse.statusCode == 200) {
                final variantData = json.decode(variantResponse.body);
                if (variantData['success'] == true && variantData['variant'] != null) {
                  product.variantDetails = VariantDetails.fromJson(variantData['variant']);
                }
              }
            } catch (e) {
              print('Error fetching variant details: $e');
            }
          }
        }
        
        return latestProducts;
      } else {
        throw Exception('Failed to load latest products');
      }
    } catch (e) {
      throw Exception('Error fetching latest products: $e');
    }
  }
} 