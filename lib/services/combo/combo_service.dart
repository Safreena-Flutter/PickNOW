import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:picknow/model/combo/combo_model.dart';

class ComboService {
  Future<List<Combo>> getcombo() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://backmern.picknow.in/api/combo/all',
        ),
      );
      debugPrint('response body : ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((combo) => Combo.fromJson(combo)).toList();
      } else {
        debugPrint('response NO');
        throw Exception('Failed to load products');
      }
    } catch (e) {
      debugPrint('response YES');
      debugPrint('Error fetching products: $e');
      return [];
    }
  }
}
