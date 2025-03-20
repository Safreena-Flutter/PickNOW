import 'package:flutter/material.dart';
import '../../model/whishlist/whishlist_model.dart';
import '../../services/whishlist/whishlist_service.dart';
class WishlistProvider extends ChangeNotifier {
  final WishlistService _wishlistService = WishlistService();
  final Set<String> _wishlist = {}; // Store product IDs in a Set
  final Map<String, bool> _loadingStatus = {}; // Track loading per product

  bool isWishlisted(String productId) => _wishlist.contains(productId);
  bool isLoading(String productId) => _loadingStatus[productId] ?? false; // Get loading status for each product

  Future<void> toggleWishlist(String productId) async {
    _loadingStatus[productId] = true; // Set loading state for the specific product
    notifyListeners();

    try {
      await _wishlistService.addToWishlist(productId);

      if (_wishlist.contains(productId)) {
        _wishlist.remove(productId); // Remove from wishlist if already there
      } else {
        _wishlist.add(productId); // Add to wishlist
      }
    } catch (e) {
      debugPrint("Error: $e");
    }

    _loadingStatus[productId] = false; // Reset loading state
    notifyListeners();
  }
  List<WishlistProduct> _wishlistproducts = [];
  bool _isLoadingproducts = false;

  List<WishlistProduct> get wishlist => _wishlistproducts;
  bool get isLoad => _isLoadingproducts;

  Future<void> loadWishlist() async {
    _isLoadingproducts = true;
    notifyListeners();

    _wishlistproducts = await _wishlistService.fetchWishlist();

    _isLoadingproducts = false;
    notifyListeners();
  }

  // void removeFromWishlist(String productId) {
  //   _wishlist.removeWhere((product) => product.id == productId);
  //   notifyListeners();
  // }

}