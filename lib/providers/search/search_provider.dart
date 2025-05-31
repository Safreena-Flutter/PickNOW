import 'package:flutter/material.dart';
import '../../model/search/search_model.dart';
import '../../services/search_service.dart';

class SearchProvider extends ChangeNotifier {
  final SearchService _service = SearchService();
  List<SearchProduct> _searchResults = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  bool _hasMore = true;
  String _lastQuery = '';

  List<SearchProduct> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasMore => _hasMore;

  Future<void> searchProducts({
    required String query,
    bool refresh = false,
  }) async {
    if (query.isEmpty) {
      clearSearch();
      return;
    }

    if (refresh || query != _lastQuery) {
      _currentPage = 1;
      _searchResults.clear(); // Reset only when necessary
      _hasMore = true;
      _lastQuery = query;
    }

    if (_isLoading || (!_hasMore && !refresh)) return;

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response =
          await _service.searchProducts(query: query, page: _currentPage);

      if (response.suggestions.products.isNotEmpty) {
        if (refresh || query != _lastQuery) {
          _searchResults = response.suggestions.products;
        } else {
          _searchResults.addAll(response.suggestions.products);
        }

        _hasMore = response.suggestions.products.isNotEmpty;
        _currentPage++;
      } else {
        _hasMore = false;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchResults = [];
    _isLoading = false;
    _error = null;
    _hasMore = false;
    notifyListeners();
  }
}
