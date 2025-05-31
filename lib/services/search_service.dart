import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/search/search_model.dart';

class SearchService {
  Future<SuggestionsResponse> searchProducts({
    required String query,
    required int page,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://backmern.picknow.in/api/search/suggestions?query=$query&page=$page'),
      );

      debugPrint('Raw API Response: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return SuggestionsResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to fetch search results');
      }
    } catch (e) {
      debugPrint('Error searching products: $e');
      return SuggestionsResponse(
        success: false,
        suggestions: Suggestions(products: [], brands: [], categories: []),
      );
    }
  }
}
