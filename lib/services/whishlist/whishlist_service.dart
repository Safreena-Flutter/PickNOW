import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/whishlist/whishlist_model.dart';

class WishlistService {
  Future<WishlistModel> addToWishlist(String productId) async {
    final url =
        Uri.parse("https://backmern.picknow.in/api/user/wishlist/$productId");
     SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception("No authentication token found.");
      }
    try {
      final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },);
      
      print('*** ${response.statusCode}');
      print('*** ${response.body}');
      if (response.statusCode == 200) {
        return WishlistModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to add product to wishlist');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
   final String baseUrl = "https://backmern.picknow.in/api/user/wishlist";

  Future<List<WishlistProduct>> fetchWishlist() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception("No authentication token found.");
      }
    try {
      final response = await http.get(Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success'] == true) {
          List<dynamic> products = data['products'];
          return products.map((json) => WishlistProduct.fromJson(json)).toList();
        }
      }
    } catch (e) {
      print("Error fetching wishlist: $e");
    }
    return [];
  }
}
