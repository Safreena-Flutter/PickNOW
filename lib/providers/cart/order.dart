import 'package:flutter/material.dart';
import 'package:picknow/model/address/address.dart';
import 'package:picknow/services/cart/order_service.dart';

class OrderProvider with ChangeNotifier {
  final OrderService _orderService = OrderService();

  bool _isPlacingOrder = false;
  bool get isPlacingOrder => _isPlacingOrder;

  Future<bool> placeOrder(Address address, String paymentId, String orderNotes) async {
    _isPlacingOrder = true;
    notifyListeners();

    final result = await _orderService.placeOrder(address, paymentId, orderNotes);

    _isPlacingOrder = false;
    notifyListeners();

    return result;
  }
}
