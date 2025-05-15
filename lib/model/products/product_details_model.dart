
class ProductDetails {
  final bool success;
  final Product product;

  ProductDetails({
    required this.success,
    required this.product,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      success: json['success'] ?? false,
      product: Product.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'product': product.toJson(),
    };
  }
}

class Product {
  final String id;
  final String name;
  final String shortDescription;
  final String description;
  final List<String> images;
  final String status;
  final String category;
  final String subCategory;
  final String nestedSubCategory;
  final int previousPrice;
  final int offer;
  final int tax;
  final String brand;
  final List<Variant> variants;
  final DateTime createdAt;
  final DateTime updatedAt;
  final VariantStats variantStats;

  Product({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.images,
    required this.status,
    required this.category,
    required this.subCategory,
    required this.nestedSubCategory,
    required this.previousPrice,
    required this.offer,
    required this.tax,
    required this.brand,
    required this.variants,
    required this.createdAt,
    required this.updatedAt,
    required this.variantStats,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['pName'],
      shortDescription: json['pShortDescription'],
      description: json['pDescription'],
      images: List<String>.from(json['pImage']),
      status: json['pStatus'],
      category: json['pCategory'],
      subCategory: json['pSubCategory'],
      nestedSubCategory: json['pNestedSubCategory'],
      previousPrice: json['pPreviousPrice'],
      offer: json['pOffer'],
      tax: json['pTax'],
      brand: json['pBrand'],
      variants: List<Variant>.from(json['variants'].map((v) => Variant.fromJson(v))),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      variantStats: VariantStats.fromJson(json['variantStats']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'pName': name,
      'pShortDescription': shortDescription,
      'pDescription': description,
      'pImage': images,
      'pStatus': status,
      'pCategory': category,
      'pSubCategory': subCategory,
      'pNestedSubCategory': nestedSubCategory,
      'pPreviousPrice': previousPrice,
      'pOffer': offer,
      'pTax': tax,
      'pBrand': brand,
      'variants': variants.map((v) => v.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'variantStats': variantStats.toJson(),
    };
  }
}

class Variant {
  final String id;
  final String productId;
  final String size;
  final String type;
  final int stock;
  final int totalStock;
  final int price;
  final int previousPrice;
  final int offer;
  final String status;

  Variant({
    required this.id,
    required this.productId,
    required this.size,
    required this.type,
    required this.stock,
    required this.totalStock,
    required this.price,
    required this.previousPrice,
    required this.offer,
    required this.status,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['_id'],
      productId: json['productId'],
      size: json['size'],
      type: json['type'],
      stock: json['stock'],
      totalStock: json['totalStock'],
      price: json['price'],
      previousPrice: json['previousPrice'],
      offer: json['offer'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productId': productId,
      'size': size,
      'type': type,
      'stock': stock,
      'totalStock': totalStock,
      'price': price,
      'previousPrice': previousPrice,
      'offer': offer,
      'status': status,
    };
  }
}

class VariantStats {
  final int totalVariants;
  final int minPrice;
  final int maxPrice;
  final int totalStock;
  final bool hasOutOfStock;

  VariantStats({
    required this.totalVariants,
    required this.minPrice,
    required this.maxPrice,
    required this.totalStock,
    required this.hasOutOfStock,
  });

  factory VariantStats.fromJson(Map<String, dynamic> json) {
    return VariantStats(
      totalVariants: json['totalVariants'],
      minPrice: json['minPrice'],
      maxPrice: json['maxPrice'],
      totalStock: json['totalStock'],
      hasOutOfStock: json['hasOutOfStock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalVariants': totalVariants,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'totalStock': totalStock,
      'hasOutOfStock': hasOutOfStock,
    };
  }
}
