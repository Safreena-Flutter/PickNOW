class Combo {
  final String id;
  final String pName;
  final String pDescription;
  final List<String> pImage;
  final String pCategory;
  final String pSubCategory;
  final String pNestedSubCategory;
  final String pBrand;
  final String pShortDescription;
  final String pType;
  final int minPrice;
  final int maxPrice;
  final int pOffer;
  final int pTax;
  final bool freeShipping;
  final bool pReturn;
  final int pReturnDays;
  final String pStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final VariantStats variantStats;
  final List<Variant> variants;

  Combo({
    required this.id,
    required this.pName,
    required this.pDescription,
    required this.pImage,
    required this.pCategory,
    required this.pSubCategory,
    required this.pNestedSubCategory,
    required this.pBrand,
    required this.pShortDescription,
    required this.pType,
    required this.minPrice,
    required this.maxPrice,
    required this.pOffer,
    required this.pTax,
    required this.freeShipping,
    required this.pReturn,
    required this.pReturnDays,
    required this.pStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.variantStats,
    required this.variants,
  });

  factory Combo.fromJson(Map<String, dynamic> json) {
    return Combo(
      id: json['_id'] ?? '',
      pName: json['pName'] ?? '',
      pDescription: json['pDescription'] ?? '',
      pImage: List<String>.from(json['pImage'] ?? []),
      pCategory: json['pCategory'] ?? '',
      pSubCategory: json['pSubCategory'] ?? '',
      pNestedSubCategory: json['pNestedSubCategory'] ?? '',
      pBrand: json['pBrand'] ?? '',
      pShortDescription: json['pShortDescription'] ?? '',
      pType: json['pType'] ?? '',
      minPrice: json['minPrice'] ?? 0,
      maxPrice: json['maxPrice'] ?? 0,
      pOffer: json['pOffer'] ?? 0,
      pTax: json['pTax'] ?? 0,
      freeShipping: json['freeshipping'] ?? false,
      pReturn: json['pReturn'] ?? false,
      pReturnDays: json['pReturnDays'] ?? 0,
      pStatus: json['pStatus'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      variantStats: VariantStats.fromJson(json['variantStats'] ?? {}),
      variants: (json['variants'] as List<dynamic>?)
              ?.map((v) => Variant.fromJson(v))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'pName': pName,
      'pDescription': pDescription,
      'pImage': pImage,
      'pCategory': pCategory,
      'pSubCategory': pSubCategory,
      'pNestedSubCategory': pNestedSubCategory,
      'pBrand': pBrand,
      'pShortDescription': pShortDescription,
      'pType': pType,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'pOffer': pOffer,
      'pTax': pTax,
      'freeshipping': freeShipping,
      'pReturn': pReturn,
      'pReturnDays': pReturnDays,
      'pStatus': pStatus,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'variantStats': variantStats.toJson(),
      'variants': variants.map((v) => v.toJson()).toList(),
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
      totalVariants: json['totalVariants'] ?? 0,
      minPrice: json['minPrice'] ?? 0,
      maxPrice: json['maxPrice'] ?? 0,
      totalStock: json['totalStock'] ?? 0,
      hasOutOfStock: json['hasOutOfStock'] ?? false,
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

class Variant {
  final String id;
  final String productId;
  final String size;
  final String type;
  final int price;
  final int offer;
  final int previousPrice;
  final int stock;
  final int totalStock;
  final bool isDefault;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Variant({
    required this.id,
    required this.productId,
    required this.size,
    required this.type,
    required this.price,
    required this.offer,
    required this.previousPrice,
    required this.stock,
    required this.totalStock,
    required this.isDefault,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['_id'] ?? '',
      productId: json['productId'] ?? '',
      size: json['size'] ?? '',
      type: json['type'] ?? '',
      price: json['price'] ?? 0,
      offer: json['offer'] ?? 0,
      previousPrice: json['previousPrice'] ?? 0,
      stock: json['stock'] ?? 0,
      totalStock: json['totalStock'] ?? 0,
      isDefault: json['isDefault'] ?? false,
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productId': productId,
      'size': size,
      'type': type,
      'price': price,
      'offer': offer,
      'previousPrice': previousPrice,
      'stock': stock,
      'totalStock': totalStock,
      'isDefault': isDefault,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
