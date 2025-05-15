import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:picknow/model/products/product_details_model.dart';


class ProductDetailService {
  Future<ProductDetails> getProductDetails(String id) async {
    try {
      final response = await http.get(
        Uri.parse('https://backmern.picknow.in/api/product/$id'),
      );
      debugPrint("reees ${response.body}");
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ProductDetails.fromJson(jsonData);
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      debugPrint('Error fetching product details: $e');
      return Future.error(e.toString());
    }
  }
}
