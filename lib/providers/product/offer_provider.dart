import 'package:flutter/material.dart';
import 'package:picknow/model/products/offer_product_model.dart';
import 'package:picknow/services/products/offer_product_service.dart';

class OfferProvider with ChangeNotifier {
  OfferProductResponse? _offerResponse;
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _offerResponse?.data ?? [];
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchOfferProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _offerResponse = await OfferProductService().fetchOfferProducts();
      _isLoading = false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
    }

    notifyListeners();
  }
}