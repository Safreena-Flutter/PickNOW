import 'package:flutter/material.dart';
import '../../model/products/related_products.dart';
import '../../services/products/related_product_service.dart';

class RelatedProductProvider extends ChangeNotifier {
  final RelatedProductService _service = RelatedProductService();
  List<RelatedProduct> _relatedProducts = [];
  bool _isLoading = false;
  String? _error;

  List<RelatedProduct> get relatedProducts => _relatedProducts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchRelatedProducts(String productId) async {
    _isLoading = true;
    _error = null;
    notifyListeners(); // Notify UI that loading has started

    try {
      final response = await _service.getRelatedProducts(productId);
      _relatedProducts = response;
      _isLoading = false;
    } catch (e) {
      _error = "Failed to load related products. Please try again.";
      _isLoading = false;
      debugPrint("Error fetching related products: $e");
    }

    notifyListeners(); // Notify UI of data or error change
  }
}
