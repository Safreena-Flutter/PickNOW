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
      products:
          List<Product>.from(json['products'].map((x) => Product.fromJson(x))),
    );
  }
}
class ProductdetailResponse {
  bool success;
  Product product;

  ProductdetailResponse({
    required this.success,
    required this.product,
  });

  factory ProductdetailResponse.fromJson(Map<String, dynamic> json) {
    return ProductdetailResponse(
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
  int pPrice;
  int? pPreviousPrice;
  int pSold;
  String pQuantity;
  String pCategory;
  String pSubCategory;
  String? pNestedSubCategory;
  int pStock;
  List<String> pImage;
  String pBrand;
  String pOffer;
  int pTax;
  String pStatus;
  List<RatingReview>? pRatingsReviews;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String? type;
  String? option;

  Product({
    required this.id,
    required this.pName,
    required this.pShortDescription,
    required this.pDescription,
    required this.pPrice,
     this.pPreviousPrice,
    required this.pSold,
    required this.pQuantity,
    required this.pCategory,
    required this.pSubCategory,
     this.pNestedSubCategory,
    required this.pStock,
    required this.pImage,
    required this.pBrand,
    required this.pOffer,
    required this.pTax,
    required this.pStatus,
     this.pRatingsReviews,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.type,
    this.option
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      pName: json['pName'],
      pShortDescription: json['pShortDescription'],
      pDescription: json['pDescription'],
      pPrice: json['pPrice'],
      pPreviousPrice: json['pPreviousPrice'],
      pSold: json['pSold'],
      pQuantity: json['pQuantity'],
      pCategory: json['pCategory'],
      pSubCategory: json['pSubCategory'],
      pNestedSubCategory: json['pNestedSubCategory']?? '',
      pStock: json['pStock'],
      pImage: List<String>.from(json['pImage']),
      pBrand: json['pBrand'],
      pOffer: json['pOffer'],
      pTax: json['pTax'],
      option: json['pOptions']?? 'weight',
      type: json['pType']?? '500g',
      pStatus: json['pStatus'],
      pRatingsReviews: json['pRatingsReviews'] != null
          ? (json['pRatingsReviews'] as List)
              .map((x) => RatingReview.fromJson(x))
              .toList()
          : [],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
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
      review: json['review']?? '4',
      user: json['user'],
      rating: json['rating']?? 'good',
      createdAt: DateTime.parse(json['createdAt']),
      id: json['_id'],
    );
  }
}
