import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:picknow/model/combo/combo_model.dart';
class ComboService {
  Future<List<Combo>> getcombo() async {
    try {
      final response = await http.get(
        Uri.parse('https://backmern.picknow.in/api/producttype/combo'),
      );
      debugPrint('response 11111 : ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Check if API returns a key like "products" or directly a list
        final List<dynamic> jsonData = 
            (data is List) ? data : data['products'] ?? [];

        return jsonData.map((combo) => Combo.fromJson(combo)).toList();
      } else {
        debugPrint('response NO');
        throw Exception('Failed to load combos');
      }
    } catch (e) {
      debugPrint('response YES');
      debugPrint('Error fetching combos: $e');
      return [];
    }
  }
}
