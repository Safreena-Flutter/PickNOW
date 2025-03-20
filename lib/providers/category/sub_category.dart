import 'package:flutter/material.dart';
import '../../model/category/category_model.dart';
import '../../services/category/sub_category.dart';

class SubCategoryProvider with ChangeNotifier {
  final SubCategoryService _service = SubCategoryService();
  List<SubCategory> _subCategories = [];
  bool _isLoading = false;

  List<SubCategory> get subCategories => _subCategories;
  bool get isLoading => _isLoading;

  Future<void> loadSubCategories(String categoryId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _subCategories = await _service.fetchSubCategories(categoryId);
    } catch (e) {
      _subCategories = [];
    }

    _isLoading = false;
    notifyListeners();
  }
  
}
