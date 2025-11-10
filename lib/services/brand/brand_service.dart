import 'dart:convert';

import '../../model/brand/brand_model.dart';
import 'package:http/http.dart' as http;

class BrandService {
  Future<List<Brand>> getBrands() async {
    final response = await http.get(
      Uri.parse('https://backmern.picknow.in/api/brand/all'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Brand.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load brands');
    }
  }
}
