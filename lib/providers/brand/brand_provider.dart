import 'package:flutter/material.dart';
import '../../model/brand/brand_model.dart';
import '../../services/brand/brand_service.dart';

class BrandProvider with ChangeNotifier {
  final BrandService _service = BrandService();

  List<Brand> _brands = [];
  bool _isLoading = false;
  String? _error;

  List<Brand> get brands => _brands;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchBrands({bool refresh = false}) async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _service.getBrands();
      _brands = response;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
