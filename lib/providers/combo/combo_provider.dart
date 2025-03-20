
import 'package:flutter/material.dart';
import 'package:picknow/model/combo/combo_model.dart';
import '../../services/combo/combo_service.dart';
class ComboListProvider extends ChangeNotifier {
  final ComboService _service = ComboService();
  List<Combo> _combos = [];
  bool _isLoading = false;
  String? _error;
  bool _hasMore = true;

  List<Combo> get products => _combos;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasMore => _hasMore;

  Future<void> comboProducts({bool refresh = false}) async {
    if (refresh) {
      _combos = [];
      _hasMore = true;
    }

    if (_isLoading || (!_hasMore && !refresh)) return;

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final List<Combo> response = await _service.getcombo();

      if (refresh) {
        _combos = response;
      } else {
        _combos.addAll(response);
      }

      _hasMore = response.isNotEmpty;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}