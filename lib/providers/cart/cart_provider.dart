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

  Future<void> addToCart(String productId, int quantity) async {
    final newCartItem = await _cartService.addToCart(productId, quantity);
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

  Future<void> updateQuantity(int index, int newQuantity) async {
    if (_cart != null && index >= 0 && index < _cart!.items.length) {
      final item = _cart!.items[index];

      bool success = await _cartService.updateCartItem(item.id, newQuantity);
      if (success) {
        _cart!.items[index].quantity = newQuantity;
        notifyListeners();
      }
    }
  }

  Future<void> removeItem(int index) async {
    if (_cart != null && index >= 0 && index < _cart!.items.length) {
      final itemId = _cart!.items[index].id;

      bool success = await _cartService.deleteCartItem(itemId);
      if (success) {
        _cart!.items.removeAt(index);
        notifyListeners();
      }
    }
  }
}
