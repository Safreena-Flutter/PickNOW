import 'package:flutter/material.dart';
import '../../model/products/product_list_model.dart';
import '../../services/product_list_service.dart';

class ProductListProvider extends ChangeNotifier {
  final ProductListService _service = ProductListService();
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;
  bool _hasMore = true;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasMore => _hasMore;

  Future<void> fetchProducts({
    required String categoryId,
    bool refresh = false,
  }) async {
    if (refresh) {
      _products = [];
      _hasMore = true;
    }

    if (_isLoading || (!_hasMore && !refresh)) return;

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      final response = await _service.getProductsByNestedCategory(
        categoryId: categoryId,
      );

      if (refresh) {
        _products = response.products;
      } else {
        _products.addAll(response.products);
      }

      _hasMore = response.products.isNotEmpty;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchcategoryProducts({
    required String categoryname,
  }) async {
    _products = [];

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      final response = await _service.fetchProductsByCategory(categoryname);

      _products.addAll(response.products);

      _hasMore = response.products.isNotEmpty;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
    Future<void> fetchbrandProducts({
    required String brandId,
  }) async {
    _products = [];

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      final response = await _service.fetchProductbybrand(brandId);

      _products.addAll(response.products);

      _hasMore = response.products.isNotEmpty;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
