class ProductResponse {
  bool success;
  List<Product> products;

  ProductResponse({
    required this.success,
    required this.products,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      success: json['success'],
      products: List<Product>.from(json['products'].map((x) => Product.fromJson(x))),
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
  String id;
  String pName;
  String pShortDescription;
  String pDescription;
  int? pPrice;
  int? pPreviousPrice;
  int? pSold;
  String? pQuantity;
  String? pCategory;
  String? pSubCategory;
  String? pNestedSubCategory;
  int? pStock;
  List<String> pImage;
  String? pBrand;
  int? pOffer;
  int? pTax;
  String? pStatus;
  List<RatingReview>? pRatingsReviews;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? type;
  String? option;

  Product({
    required this.id,
    required this.pName,
    required this.pShortDescription,
    required this.pDescription,
    this.pPrice,
    this.pPreviousPrice,
    this.pSold,
    this.pQuantity,
    this.pCategory,
    this.pSubCategory,
    this.pNestedSubCategory,
    this.pStock,
    required this.pImage,
    this.pBrand,
    this.pOffer,
    this.pTax,
    this.pStatus,
    this.pRatingsReviews,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.type,
    this.option,
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
