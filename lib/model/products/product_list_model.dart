import 'package:picknow/model/products/latest_product_model.dart';

class ProductResponse {
  final bool success;
  final List<Product> products;

  ProductResponse({
    required this.success,
    required this.products,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      success: json['success'],
      products: List<Product>.from(
        json['products'].map((x) => Product.fromJson(x)),
      ),
    );
  }
}

class ProductDetailResponse {
  bool success;
  Product product;

  ProductDetailResponse({
    required this.success,
    required this.product,
  });

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailResponse(
      success: json['success'],
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  final String id;
  final String pName;
  final String pShortDescription;
  final String pDescription;
  int? pPrice;
  int? pPreviousPrice;
  int? pSold;
  String? pQuantity;
  final String pCategory;
  final String pSubCategory;
  final String pNestedSubCategory;
  int? pStock;
  final List<String> pImage;
  final String pBrand;
  int? pOffer;
  int? pTax;
  String? pStatus;
  List<RatingReview>? pRatingsReviews;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? type;
  String? option;
  final List<String> variants;
  VariantDetails? variantDetails;

  Product({
    required this.id,
    required this.pName,
    required this.pShortDescription,
    required this.pDescription,
    this.pPrice,
    this.pPreviousPrice,
    this.pSold,
    this.pQuantity,
    required this.pCategory,
    required this.pSubCategory,
    required this.pNestedSubCategory,
    this.pStock,
    required this.pImage,
    required this.pBrand,
    this.pOffer,
    this.pTax,
    this.pStatus,
    this.pRatingsReviews,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.type,
    this.option,
    required this.variants,
    this.variantDetails,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      pName: json['pName'],
      pShortDescription: json['pShortDescription'],
      pDescription: json['pDescription'],
      pPrice: json['price'] is int ? json['price'] : int.tryParse(json['price']?.toString() ?? '0'),
      pPreviousPrice: json['pPreviousPrice'],
      pSold: json['pSold'],
      pQuantity: json['pQuantity'],
      pCategory: json['pCategory'],
      pSubCategory: json['pSubCategory'],
      pNestedSubCategory: json['pNestedSubCategory'],
      pStock: json['pStock'],
      pImage: List<String>.from(json['pImage']),
      pBrand: json['pBrand'],
      pOffer: json['pOffer'] is int ? json['pOffer'] : int.tryParse(json['pOffer']?.toString() ?? '0'),
      pTax: json['pTax'],
      option: json['pOptions'] ?? 'weight',
      type: json['pType'] ?? '500g',
      pStatus: json['pStatus'],
      pRatingsReviews: json['pRatingsReviews'] != null
          ? (json['pRatingsReviews'] as List)
              .map((x) => RatingReview.fromJson(x))
              .toList()
          : [],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
      variants: List<String>.from(json['variants']),
    );
  }
}

class RatingReview {
  String? review;
  String user;
  String? rating;
  DateTime createdAt;
  String id;

  RatingReview({
    this.review,
    required this.user,
    this.rating,
    required this.createdAt,
    required this.id,
  });

  factory RatingReview.fromJson(Map<String, dynamic> json) {
    return RatingReview(
      review: json['review'] ?? '4',
      user: json['user'],
      rating: json['rating'] ?? 'good',
      createdAt: DateTime.parse(json['createdAt']),
      id: json['_id'],
    );
  }
}
