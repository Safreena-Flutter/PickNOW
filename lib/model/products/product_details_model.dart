
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
      product: Product.fromJson(json['product'] ?? {}),
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
      id: (json['_id'] ?? '').toString(),
      name: (json['pName'] ?? '').toString(),
      shortDescription: (json['pShortDescription'] ?? '').toString(),
      description: (json['pDescription'] ?? '').toString(),
      images: (json['pImage'] as List?)?.map((e) => e.toString()).toList() ?? const [],
      status: (json['pStatus'] ?? '').toString(),
      category: (json['pCategory'] ?? '').toString(),
      subCategory: (json['pSubCategory'] ?? '').toString(),
      nestedSubCategory: (json['pNestedSubCategory'] ?? '').toString(),
      previousPrice: _asInt(json['pPreviousPrice']),
      offer: _asInt(json['pOffer']),
      tax: _asInt(json['pTax']),
      brand: (json['pBrand'] ?? '').toString(),
      variants: ((json['variants'] as List?) ?? const [])
          .map((v) => Variant.fromJson((v as Map?)?.cast<String, dynamic>() ?? {}))
          .toList(),
      createdAt: _asDate(json['createdAt']),
      updatedAt: _asDate(json['updatedAt']),
      variantStats: VariantStats.fromJson((json['variantStats'] as Map?)?.cast<String, dynamic>() ?? {}),
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
      id: (json['_id'] ?? '').toString(),
      productId: (json['productId'] ?? '').toString(),
      size: (json['size'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      stock: _asInt(json['stock']),
      totalStock: _asInt(json['totalStock']),
      price: _asInt(json['price']),
      previousPrice: _asInt(json['previousPrice']),
      offer: _asInt(json['offer']),
      status: (json['status'] ?? '').toString(),
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
      totalVariants: _asInt(json['totalVariants']),
      minPrice: _asInt(json['minPrice']),
      maxPrice: _asInt(json['maxPrice']),
      totalStock: _asInt(json['totalStock']),
      hasOutOfStock: _asBool(json['hasOutOfStock']),
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

int _asInt(dynamic v) {
  if (v == null) return 0;
  if (v is int) return v;
  if (v is double) return v.toInt();
  if (v is String) return int.tryParse(v) ?? 0;
  return 0;
}

bool _asBool(dynamic v) {
  if (v == null) return false;
  if (v is bool) return v;
  if (v is num) return v != 0;
  if (v is String) {
    final s = v.toLowerCase();
    if (s == 'true') return true;
    if (s == 'false') return false;
    final n = int.tryParse(s);
    return (n ?? 0) != 0;
  }
  return false;
}

DateTime _asDate(dynamic v) {
  if (v == null) return DateTime.fromMillisecondsSinceEpoch(0);
  if (v is DateTime) return v;
  return DateTime.tryParse(v.toString()) ?? DateTime.fromMillisecondsSinceEpoch(0);
}
