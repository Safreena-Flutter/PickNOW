import 'package:flutter/material.dart';
import 'package:picknow/model/products/latest_product_model.dart';
import 'package:picknow/services/products/latest_product_service.dart';

class LatestProductProvider with ChangeNotifier {
  LatestProductResponse? _latestProducts;
  bool _isLoading = false;
  String? _error;

  List<LatestProduct> get products => _latestProducts?.products ?? [];
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchLatestProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _latestProducts = await LatestProductService().fetchLatestProducts();
      _isLoading = false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
    }

    notifyListeners();
  }
} 