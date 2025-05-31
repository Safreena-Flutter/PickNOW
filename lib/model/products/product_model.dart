class ProductModel {
  final String id;
  final String name;
  final String shortDescription;
  final String description;
  final List<String> images;
  final String status;
  final String category;
  final String subCategory;
  final String nestedSubCategory;
  final double previousPrice;
  final double offer;
  final double tax;
  final String brand;
  final bool isReturnable;
  final int returnDays;
  final List<ProductVariant> variants;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
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
    required this.isReturnable,
    required this.returnDays,
    required this.variants,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      name: json['pName'],
      shortDescription: json['pShortDescription'],
      description: json['pDescription'],
      images: List<String>.from(json['pImage']),
      status: json['pStatus'],
      category: json['pCategory'],
      subCategory: json['pSubCategory'],
      nestedSubCategory: json['pNestedSubCategory'],
      previousPrice: (json['pPreviousPrice'] as num).toDouble(),
      offer: (json['pOffer'] as num).toDouble(),
      tax: (json['pTax'] as num).toDouble(),
      brand: json['pBrand'],
      isReturnable: json['pReturn'],
      returnDays: json['pReturnDays'],
      variants: (json['variants'] as List)
          .map((variant) => ProductVariant.fromJson(variant))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class ProductVariant {
  final String id;
  final String productId;
  final String size;
  final String type;
  final int stock;
  final int totalStock;
  final double price;
  final double previousPrice;
  final double offer;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductVariant({
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
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['_id'],
      productId: json['productId'],
      size: json['size'],
      type: json['type'],
      stock: json['stock'],
      totalStock: json['totalStock'],
      price: (json['price'] as num).toDouble(),
      previousPrice: (json['previousPrice'] as num).toDouble(),
      offer: (json['offer'] as num).toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
} 