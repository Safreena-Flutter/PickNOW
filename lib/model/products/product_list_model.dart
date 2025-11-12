


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
  List<RatingReviews>? pRatingsReviews;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? type;
  String? option;
  final List<String> variants;
  VariantDetails? variantDetails;
  bool? freeshipping;
  bool? pisVoucher50;
  bool? pisVoucher100;
  String? vendorId;
  String? createdBy;
  String? editedBy;
  double? averageRating;
  int? totalReviews;
  bool? pReturn;
  int? pReturnDays;

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
    this.freeshipping,
    this.pisVoucher50,
    this.pisVoucher100,
    this.vendorId,
    this.createdBy,
    this.editedBy,
    this.averageRating,
    this.totalReviews,
    this.pReturn,
    this.pReturnDays,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      pName: json['pName'] ?? '',
      pShortDescription: json['pShortDescription'] ?? '',
      pDescription: json['pDescription'] ?? '',
      pPrice: json['pPrice'] is int
          ? json['pPrice']
          : int.tryParse(json['pPrice']?.toString() ?? '0'),
      pPreviousPrice: json['pPreviousPrice'] ?? 0,
      pSold: json['pSold'],
      pQuantity: json['pQuantity'],
      pCategory: json['pCategory'] ?? '',
      pSubCategory: json['pSubCategory'] ?? '',
      pNestedSubCategory: json['pNestedSubCategory'] ?? '',
      pStock: json['pStock'],
      pImage: List<String>.from(json['pImage'] ?? []),
      pBrand: json['pBrand'] ?? '',
      pOffer: json['pOffer'] is int
          ? json['pOffer']
          : int.tryParse(json['pOffer']?.toString() ?? '0'),
      pTax: json['pTax'],
      option: json['pOptions'],
      type: json['pType'],
      pStatus: json['pStatus'],
      pRatingsReviews: json['pRatingsReviews'] != null
          ? (json['pRatingsReviews'] as List)
              .map((x) => RatingReviews.fromJson(x))
              .toList()
          : [],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      v: json['__v'],
      variants: List<String>.from(json['variants'] ?? []),
      freeshipping: json['freeshipping'],
      pisVoucher50: json['pis_voucher_50'],
      pisVoucher100: json['pis_voucher_100'],
      vendorId: json['vendorId'],
      createdBy: json['createdBy'],
      editedBy: json['editedBy'],
      averageRating: double.tryParse(json['averageRating']?.toString() ?? '0'),
      totalReviews: json['totalReviews'] ?? 0,
      pReturn: json['pReturn'],
      pReturnDays: json['pReturnDays'],
    );
  }
}


class VariantDetails {
  final String id;
  final String productId;
  final String size;
  final String type;
  final int price;
  final int? previousPrice; // nullable
  final int offer;
  final int stock;
  final int totalStock;
  final String status;

  VariantDetails({
    required this.id,
    required this.productId,
    required this.size,
    required this.type,
    required this.price,
    this.previousPrice, // optional
    required this.offer,
    required this.stock,
    required this.totalStock,
    required this.status,
  });

  factory VariantDetails.fromJson(Map<String, dynamic> json) {
    return VariantDetails(
      id: json['_id'] ?? '',
      productId: json['productId'] ?? '',
      size: json['size'] ?? '',
      type: json['type'] ?? '',
      price: json['price'] ?? 0,
      previousPrice: json['previousPrice'] ?? 0, // can be null
      offer: json['offer'] ?? 0,
      stock: json['stock'] ?? 0,
      totalStock: json['totalStock'] ?? 0,
      status: json['status'] ?? '',
    );
  }
}
class RatingReviews {
  final String id;
  final String? review;
  final String? rating;
  final DateTime createdAt;
  final RatingUser? user;

  RatingReviews({
    required this.id,
    this.review,
    this.rating,
    required this.createdAt,
    this.user,
  });

  factory RatingReviews.fromJson(Map<String, dynamic> json) {
    dynamic userData = json['user'];
    RatingUser? parsedUser;

    if (userData is Map<String, dynamic>) {
      parsedUser = RatingUser.fromJson(userData);
    } else if (userData is String) {
      parsedUser = RatingUser(id: userData, name: ""); // fallback when only ID
    }

    return RatingReviews(
      id: json['_id'] ?? '',
      review: json['review'],
      rating: json['rating']?.toString(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
          : DateTime.now(),
      user: parsedUser,
    );
  }
}

class RatingUser {
  final String id;
  final String name;

  RatingUser({
    required this.id,
    required this.name,
  });

  factory RatingUser.fromJson(Map<String, dynamic> json) {
    return RatingUser(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
