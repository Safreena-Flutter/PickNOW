import 'package:flutter/material.dart';

class SuggestionsResponse {
  final bool success;
  final Suggestions suggestions;

  SuggestionsResponse({
    required this.success,
    required this.suggestions,
  });

  factory SuggestionsResponse.fromJson(Map<String, dynamic> json) {
    return SuggestionsResponse(
      success: json['success'] ?? false,
      suggestions: json.containsKey('suggestions')
          ? Suggestions.fromJson(json['suggestions'])
          : Suggestions(products: [], brands: [], categories: []),
    );
  }
}

class Suggestions {
  final List<SearchProduct> products;
  final List<Brand> brands;
  final List<dynamic> categories;

  Suggestions({
    required this.products,
    required this.brands,
    required this.categories,
  });

  factory Suggestions.fromJson(Map<String, dynamic> json) {
    final productList = json['products'] as List? ?? [];
    debugPrint('Parsed Products: $productList'); // Debugging line

    return Suggestions(
      products: productList.map((p) => SearchProduct.fromJson(p)).toList(),
      brands:
          (json['brands'] as List?)?.map((b) => Brand.fromJson(b)).toList() ??
              [],
      categories: json['categories'] as List? ?? [],
    );
  }
}

class Brand {
  final String type;
  final String name;

  Brand({required this.type, required this.name});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      type: json['type'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class SearchProduct {
  final String type;
  final String id;
  final String name;
  final String category;
  final String brand;
  final int price;
  final String image;

  SearchProduct({
    required this.type,
    required this.id,
    required this.name,
    required this.category,
    required this.brand,
    required this.price,
    required this.image,
  });

  factory SearchProduct.fromJson(Map<String, dynamic> json) {
    return SearchProduct(
      type: json['type'] ?? '',
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      brand: json['brand'] ?? '',
      price: json['price'] ?? 0,
      image: json['image'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, category: $category, brand: $brand, price: $price, image: $image)';
  }
}
