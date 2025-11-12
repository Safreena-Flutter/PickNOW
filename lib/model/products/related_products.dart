import 'dart:convert';


class RatingReview {
  final String review;
  final String userId;
  final int rating;
  final DateTime createdAt;
  final String id;

  RatingReview({
    required this.review,
    required this.userId,
    required this.rating,
    required this.createdAt,
    required this.id,
  });

  factory RatingReview.fromJson(Map<String, dynamic> json) {
    return RatingReview(
      review: json['review'] ?? '',
      userId: json['user'] ?? '',
      rating: int.tryParse(json['rating']?.toString() ?? '0') ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
          : DateTime.now(),
      id: json['_id'] ?? '',
    );
  }
}

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
  final String? createdBy;
  final String? editedBy;
  final List<RatingReview> ratingsReviews;
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
    this.createdBy,
    this.editedBy,
    required this.ratingsReviews,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RelatedProduct.fromJson(Map<String, dynamic> json) {
    return RelatedProduct(
      id: json['_id'] ?? '',
      name: json['pName'] ?? 'Unknown',
      shortDescription: json['pShortDescription'] ?? '',
      description: json['pDescription'] ?? '',
      price: (json['pPrice'] != null)
          ? int.tryParse(json['pPrice'].toString()) ?? 0
          : 0,
      previousPrice: (json['pPreviousPrice'] != null)
          ? int.tryParse(json['pPreviousPrice'].toString()) ?? 0
          : 0,
      sold: (json['pSold'] != null)
          ? int.tryParse(json['pSold'].toString()) ?? 0
          : 0,
      quantity: json['pQuantity'] ?? '',
      category: json['pCategory'] ?? '',
      subCategory: json['pSubCategory'] ?? '',
      nestedSubCategory: json['pNestedSubCategory'],
      stock: json['pStock'] ?? 0,
      images: (json['pImage'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      brand: json['pBrand'] ?? '',
      offer: (json['pOffer'] != null)
          ? int.tryParse(json['pOffer'].toString()) ?? 0
          : 0,
      tax: (json['pTax'] != null) ? int.tryParse(json['pTax'].toString()) ?? 0 : 0,
      status: json['pStatus'] ?? '',
      createdBy: json['createdBy'],
      editedBy: json['editedBy'],
      ratingsReviews: (json['pRatingsReviews'] as List<dynamic>?)
              ?.map((e) => RatingReview.fromJson(e))
              .toList() ??
          [],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt']) ?? DateTime.now()
          : DateTime.now(),
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
      relatedProducts:
          RelatedProduct.listFromJson(jsonData['relatedProducts'] as List<dynamic>?),
    );
  }
}
