


import 'package:picknow/model/products/product_details_model.dart';

class ProductBrandResponse {
  final bool success;
  final int count;
  final int total;
  final int totalPages;
  final int currentPage;
  final List<Product> products;

  ProductBrandResponse({
    required this.success,
    required this.count,
    required this.total,
    required this.totalPages,
    required this.currentPage,
    required this.products,
  });

  factory ProductBrandResponse.fromJson(Map<String, dynamic> json) {
    return ProductBrandResponse(
      success: json['success'] ?? false,
      count: json['count'] ?? 0,
      total: json['total'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
      products:  List<Product>.from(
        json['products'].map((x) => Product.fromJson(x)),
      ),
    );
  }
}