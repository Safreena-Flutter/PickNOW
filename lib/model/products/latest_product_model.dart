class LatestProductResponse {
  final bool success;
  final int count;
  final List<LatestProduct> products;

  LatestProductResponse({
    required this.success,
    required this.count,
    required this.products,
  });

  factory LatestProductResponse.fromJson(Map<String, dynamic> json) {
    return LatestProductResponse(
      success: json['success'],
      count: json['count'],
      products: List<LatestProduct>.from(
        json['products'].map((x) => LatestProduct.fromJson(x)),
      ),
    );
  }
}

class LatestProduct {
  final String id;
  final String pName;
  final String pShortDescription;
  final String pDescription;
  final List<String> pImage;
  final String pCategory;
  final String pSubCategory;
  final String pNestedSubCategory;
  final String pBrand;
  final List<String> variants;
  VariantDetails? variantDetails;

  LatestProduct({
    required this.id,
    required this.pName,
    required this.pShortDescription,
    required this.pDescription,
    required this.pImage,
    required this.pCategory,
    required this.pSubCategory,
    required this.pNestedSubCategory,
    required this.pBrand,
    required this.variants,
    this.variantDetails,
  });

  factory LatestProduct.fromJson(Map<String, dynamic> json) {
    return LatestProduct(
      id: json['_id'],
      pName: json['pName'],
      pShortDescription: json['pShortDescription'],
      pDescription: json['pDescription'],
      pImage: List<String>.from(json['pImage']),
      pCategory: json['pCategory'],
      pSubCategory: json['pSubCategory'],
      pNestedSubCategory: json['pNestedSubCategory'],
      pBrand: json['pBrand'],
      variants: List<String>.from(json['variants']),
    );
  }
}

class VariantDetails {
  final String id;
  final String productId;
  final String size;
  final String type;
  final int price;
  final int previousPrice;
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
    required this.previousPrice,
    required this.offer,
    required this.stock,
    required this.totalStock,
    required this.status,
  });

  factory VariantDetails.fromJson(Map<String, dynamic> json) {
    return VariantDetails(
      id: json['_id'],
      productId: json['productId'],
      size: json['size'],
      type: json['type'],
      price: json['price'],
      previousPrice: json['previousPrice'],
      offer: json['offer'],
      stock: json['stock'],
      totalStock: json['totalStock'],
      status: json['status'],
    );
  }
} 