import 'package:flutter/foundation.dart';
import '../models/combo_model.dart';
import '../models/product_model.dart';
import '../services/combo_service.dart';
import '../services/product_service.dart';

class ComboProvider with ChangeNotifier {
  final ComboService _comboService = ComboService();
  final ProductService _productService = ProductService();
  ComboModel? _combo;
  Map<String, ProductModel> _products = {};
  bool _isLoading = false;
  String? _error;

  ComboModel? get combo => _combo;
  Map<String, ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchComboDetails(String comboId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _combo = await _comboService.getComboDetails(comboId);
      _error = null;
      
      // Fetch product details for each product in the combo
      for (var product in _combo!.products) {
        if (!_products.containsKey(product.productId)) {
          try {
            final productDetails = await _productService.getProductDetails(product.productId);
            _products[product.productId] = productDetails;
          } catch (e) {
            print('Error fetching product ${product.productId}: $e');
          }
        }
      }
    } catch (e) {
      _error = e.toString();
      _combo = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 