import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/products/product_list_model.dart';

class ProductDetailService {
  Future<ProductdetailResponse> getProductDetails(String id) async {
    try {
      final response = await http.get(
        Uri.parse('https://backmern.picknow.in/api/product/$id'),
      );
      debugPrint("Resoponse body: ${response.body}");
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        debugPrint('pree $jsonData');
        return ProductdetailResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      debugPrint('Error fetching product details: $e');
      return Future.error(e.toString());
    }
  }
}
