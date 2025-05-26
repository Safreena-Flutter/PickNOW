import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/combo_model.dart';

class ComboService {
  final String baseUrl = 'https://backmern.picknow.in/api';

  Future<ComboModel> getComboDetails(String comboId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/combo/$comboId'));
print('body ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success'] == true) {
          return ComboModel.fromJson(data['combo']);
        } else {
          throw Exception('Failed to load combo details');
        }
      } else {
        throw Exception('Failed to load combo details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
} 