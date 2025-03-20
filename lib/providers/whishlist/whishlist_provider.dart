import 'package:flutter/material.dart';
import '../../services/whishlist/whishlist_service.dart';

class WishlistProvider extends ChangeNotifier {
  final WishlistService _wishlistService = WishlistService();
  bool _isLoading = false;
  bool _isWishlisted = false;

  bool get isLoading => _isLoading;
  bool get isWishlisted => _isWishlisted;

  Future<void> toggleWishlist(String productId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _wishlistService.addToWishlist(productId);
      _isWishlisted = !_isWishlisted;
    } catch (e) {
      debugPrint("Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
