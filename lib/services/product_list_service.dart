import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/products/product_list_model.dart';

class ProductListService {
  Future<ProductResponse> getProductsByNestedCategory({
    required String categoryId,
  }) async {
    try {
   
      final response = await http.get(
        Uri.parse(
          'https://backmern.picknow.in/api/products/nested-subcategory/$categoryId',
        ),
      );
      debugPrint('response status code ${response.statusCode}');
      debugPrint('response body11 : ${response.body}');
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ProductResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      debugPrint("hall");
      debugPrint('Error fetching products: $e');
      return ProductResponse(
        products: [],
        success: false,
      );
    }
  }

  Future<ProductResponse> fetchProductsByCategory(String categoryName) async {
    final url =
        "https://backmern.picknow.in/api/category/$categoryName/products";

    try {
      final response = await http.get(Uri.parse(url));
print('rr ');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["success"] == true) {
          final jsonData = json.decode(response.body);
          return ProductResponse.fromJson(jsonData);
        } else {
          throw Exception("Failed to load products");
        }
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
