import 'package:flutter/material.dart';
import 'package:picknow/model/products/product_details_model.dart';
import '../../services/product_detail_service.dart';

class ProductDetailProvider extends ChangeNotifier {
  final ProductDetailService _service = ProductDetailService();
  ProductDetails? _productDetail;
  bool _isLoading = false;
  String? _error;

  ProductDetails? get productDetail => _productDetail;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProductDetails(String id) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      debugPrint('came');
      debugPrint('id $id');
      _productDetail = await _service.getProductDetails(id);
      _isLoading = false;
      debugPrint('came ccc');
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
