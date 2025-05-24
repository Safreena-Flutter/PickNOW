import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:picknow/model/products/offer_product_model.dart';

class OfferProductService {
  Future<OfferProductResponse> fetchOfferProducts() async {
    try {
      final response = await http.get(Uri.parse('https://backmern.picknow.in/api/products/offer'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return OfferProductResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load offer products');
      }
    } catch (e) {
      throw Exception('Error fetching offer products: $e');
    }
  }
}