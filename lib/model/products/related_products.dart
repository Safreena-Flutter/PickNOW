import 'dart:convert';
import 'product_list_model.dart';

class RelatedProduct {
  final String id;
  final String name;
  final String shortDescription;
  final String description;
  final int price;
  final int previousPrice;
  final int sold;
  final String quantity;
  final String category;
  final String subCategory;
  final String? nestedSubCategory;
  final int stock;
  final List<String> images;
  final String brand;
  final int offer;
  final int tax;
  final String status;
  final String createdBy;
  final String editedBy;
  final List<RatingReview>? ratingsReviews;
  final DateTime createdAt;
  final DateTime updatedAt;

  RelatedProduct({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.price,
    required this.previousPrice,
    required this.sold,
    required this.quantity,
    required this.category,
    required this.subCategory,
    this.nestedSubCategory,
    required this.stock,
    required this.images,
    required this.brand,
    required this.offer,
    required this.tax,
    required this.status,
    required this.createdBy,
    required this.editedBy,
    this.ratingsReviews,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RelatedProduct.fromJson(Map<String, dynamic> json) {
    return RelatedProduct(
      id: json['_id'] ?? '',
      name: json['pName'] ?? 'Unknown',
      shortDescription: json['pShortDescription'] ?? '',
      description: json['pDescription'] ?? '',
      price: json['pPrice'] ?? 0,
      previousPrice: json['pPreviousPrice'] ?? 0,
      sold: json['pSold'] ?? 0,
      quantity: json['pQuantity'] ?? '',
      category: json['pCategory'] ?? '',
      subCategory: json['pSubCategory'] ?? '',
      nestedSubCategory: json['pNestedSubCategory'], // nullable
      stock: json['pStock'] ?? 0,
      images: (json['pImage'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      brand: json['pBrand'] ?? '',
      offer: (json['pOffer'] != null && json['pOffer'].toString().isNotEmpty)
          ? int.tryParse(json['pOffer'].toString()) ?? 0
          : 0,
      tax: json['pTax'] ?? 0,
      status: json['pStatus'] ?? '',
      createdBy: json['createdBy'] ?? '',
      editedBy: json['editedBy'] ?? '',
      ratingsReviews: (json['pRatingsReviews'] as List<dynamic>?)
          ?.map((x) => RatingReview.fromJson(x))
          .toList() ??
          [],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) ?? DateTime.now() : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) ?? DateTime.now() : DateTime.now(),
    );
  }

  static List<RelatedProduct> listFromJson(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList.map((data) => RelatedProduct.fromJson(data)).toList();
  }
}

class RelatedProductResponse {
  final bool success;
  final int count;
  final List<RelatedProduct> relatedProducts;

  RelatedProductResponse({
    required this.success,
    required this.count,
    required this.relatedProducts,
  });

  factory RelatedProductResponse.fromJson(String source) {
    final Map<String, dynamic> jsonData = json.decode(source);
    return RelatedProductResponse(
      success: jsonData['success'] ?? false,
      count: jsonData['count'] ?? 0,
      relatedProducts: RelatedProduct.listFromJson(jsonData['relatedProducts'] as List<dynamic>?),
    );
  }
}
