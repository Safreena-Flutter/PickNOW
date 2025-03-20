import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../model/products/related_products.dart';

class RelatedProductService {
  Future<List<RelatedProduct>> getRelatedProducts(String productId) async {
    final String url =
        'https://backmern.picknow.in/api/products/$productId/related';

    try {
      final response = await http.get(Uri.parse(url));
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        if (jsonData['success'] == true) {
          return RelatedProduct.listFromJson(jsonData['relatedProducts']);
        } else {
          throw Exception('Failed to fetch related products');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint('Error fetching related products: $e');
      return [];
    }
  }
}
