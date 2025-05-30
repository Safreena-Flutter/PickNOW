// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:picknow/model/cart/cart_model.dart';
import '../../services/cart/cart_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartProvider with ChangeNotifier {
  CartModel? _cart;
  bool _isLoading = false;
  final CartService _cartService = CartService();

  CartModel? get cart => _cart;
  bool get isLoading => _isLoading;
  int get itemCount {
    return _cart?.items.length ?? 0;
  }

  Future<void> loadCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedCart = await _cartService.fetchCartItems();
      _cart = fetchedCart;
    } catch (error) {
      debugPrint("Error fetching cart: $error");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addToCart(String productId, int quantity, String variantType,
      String variantvalue, int price, String variantid) async {
    final newCartItem = await _cartService.addToCart(
        productId, quantity, variantType, variantvalue, price, variantid);
    if (newCartItem != null) {
      _cart?.items.add(newCartItem);
      notifyListeners();
      Fluttertoast.showToast(
        msg: "Product added to cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    }
  }

  Future<void> updateQuantity(
      int index,
      int newQuantity,
      String variantType,
      String variantvalue,
      num price,
      String variantid,
      String productid) async {
    if (_cart != null && index >= 0 && index < _cart!.items.length) {
      final item = _cart!.items[index];

      bool success = await _cartService.updateCartItem(
          productid, newQuantity, variantType, variantvalue, price, variantid);
      if (success) {
        // Reload the cart to get updated totals
        await loadCart();
      }
    }
  }

  Future<void> removeItem(int index, String productId, String variantId,
      String variantType, String variantvalue) async {
    if (_cart != null && index >= 0 && index < _cart!.items.length) {
      try {
        bool success = await _cartService.deleteCartItem(
            productId, variantId, variantType, variantvalue);
        if (success) {
          _cart!.items.removeAt(index);
          notifyListeners();
          return;
        }
        throw Exception('Failed to delete item from backend');
      } catch (error) {
        debugPrint("Error removing item: $error");
        throw error;
      }
    }
    throw Exception('Invalid item index');
  }
}
