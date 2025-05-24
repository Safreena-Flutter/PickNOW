// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/whishlist/whishlist_model.dart';
import 'package:http/http.dart' as http;
import '../../services/whishlist/whishlist_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class WishlistProvider extends ChangeNotifier {
  final WishlistService _wishlistService = WishlistService();
  final Set<String> _wishlist = {}; 
  final Map<String, bool> _loadingStatus = {}; 

  List<WishlistProduct> _wishlistProducts = [];
  bool _isLoadingProducts = false;

  List<WishlistProduct> get wishlist => _wishlistProducts;
  bool get isLoadingProducts => _isLoadingProducts;

  bool isWishlisted(String productId) => _wishlist.contains(productId);
  bool isLoading(String productId) => _loadingStatus[productId] ?? false;

  /// Toggle Wishlist (Add/Remove)
  Future<void> toggleWishlist(String productId,String varientid) async {
    _loadingStatus[productId] = true;
    notifyListeners();

    try {
      if (isWishlisted(productId)) {
        await removeFromWishlist(productId);
      } else {
        await addToWishlist(productId,varientid);
      }
    } catch (e) {
      debugPrint("Error: $e");
    }

    _loadingStatus[productId] = false;
    notifyListeners();
  }

  /// Add to Wishlist
  Future<void> addToWishlist(String productId, String varientid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception("No authentication token found.");
      }

      final url = Uri.parse("https://backmern.picknow.in/api/user/wishlist/$productId");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'variantId': varientid,
        }),
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          _wishlist.add(productId);
          Fluttertoast.showToast(
            msg: "Product added to wishlist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
        } else {
          throw Exception(responseData['message'] ?? "Failed to add product to wishlist");
        }
      } else {
        throw Exception("Failed to add product to wishlist");
      }
    } catch (e) {
      debugPrint("Error adding to wishlist: $e");
      rethrow;
    }

    notifyListeners();
  }

  /// Remove from Wishlist
  Future<void> removeFromWishlist(String productId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception("No authentication token found.");
      }

      final url = Uri.parse("https://backmern.picknow.in/api/user/wishlist/$productId");
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _wishlist.remove(productId);
        _wishlistProducts.removeWhere((product) => product.id == productId);
        Fluttertoast.showToast(
          msg: "Product removed from wishlist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else {
        throw Exception("Failed to remove product from wishlist");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }

    notifyListeners();
  }

  /// Load Wishlist from API
  Future<void> loadWishlist() async {
    _isLoadingProducts = true;
    notifyListeners();

    try {
      final response = await _wishlistService.fetchWishlist();
      _wishlistProducts = response;
      _wishlist.clear();
      for (var product in _wishlistProducts) {
        _wishlist.add(product.id);
      }
    } catch (e) {
      debugPrint("Error loading wishlist: $e");
    }

    _isLoadingProducts = false;
    notifyListeners();
  }
}
