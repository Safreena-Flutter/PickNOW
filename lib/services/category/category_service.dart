import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:picknow/core/costants/api/baseurl.dart';
import '../../model/category/category_model.dart';

class CategoryService {

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(allcategory));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((category) => CategoryModel.fromJson(category))
            .toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }
}