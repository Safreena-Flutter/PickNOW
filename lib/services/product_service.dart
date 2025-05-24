import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductService {
  final String baseUrl = 'https://backmern.picknow.in/api';

  Future<ProductModel> getProductDetails(String productId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/product/$productId'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success'] == true) {
          return ProductModel.fromJson(data['product']);
        } else {
          throw Exception('Failed to load product details');
        }
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
} 