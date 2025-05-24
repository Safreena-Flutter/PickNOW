import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:picknow/model/cart/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  final String baseUrl = "https://backmern.picknow.in/api/cart";

  Future<CartItem?> addToCart(
      String productId,
      int quantity,
      String variantType,
      String variantvalue,
      int price,
      String variantid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception("No authentication token found.");
    }

    final url = Uri.parse("$baseUrl/add");
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "productId": productId,
        "quantity": quantity,
        "variantType": variantType,
        "variantValue": variantvalue,
        "price": price,
        "variantId": variantid,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData["success"]) {
        return CartItem.fromJson(responseData["cart"]["items"].last);
      }
    }
    return null;
  }

  Future<CartModel?> fetchCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception("No authentication token found.");
    }
    print('####token $token');
    final response = await http.get(
      Uri.parse('$baseUrl/get'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return CartResponse.fromJson(data).cart;
    } else {
      throw Exception("Failed to fetch cart data.");
    }
  }

  Future<bool> updateCartItem(
      String productId,
      int newQuantity,
      String variantType,
      String variantvalue,
      num price,
      String variantid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception("No authentication token found.");
    }

    final response = await http.put(
      Uri.parse("$baseUrl/update"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "productId": productId,
        "quantity": newQuantity,
        "variantType": variantType,
        "variantValue": variantvalue,
        "price": price,
        "variantId": variantid,
      }),
    );

    return response.statusCode == 200;
  }

  Future<bool> deleteCartItem(String productId, String variantId,
      String variantType, String variantvalue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception("No authentication token found.");
    }

    final queryParams = {
      'productId': productId,
      'variantId': variantId,
      'variantType': variantType,
      'variantValue': variantvalue,
    };

    final uri =
        Uri.parse("$baseUrl/remove").replace(queryParameters: queryParams);

    final response = await http.delete(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    print('rre ${response.statusCode}');
    print('rre ${response.body}');
    return response.statusCode == 200;
  }
}
