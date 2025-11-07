import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/whishlist/whishlist_model.dart';

class WishlistService {

  final String baseUrl = "https://backmern.picknow.in/api/user/wishlist";

  Future<List<WishlistProduct>> fetchWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    print('tokeenn $token');
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success'] == true) {
          List<dynamic> products = data['products'];
          return products
              .map((json) => WishlistProduct.fromJson(json))
              .toList();
        }
      }
    } catch (e) {
      debugPrint("Error fetching wishlist: $e");
    }
    return [];
  }
}
