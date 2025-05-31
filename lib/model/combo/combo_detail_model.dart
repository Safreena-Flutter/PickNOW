class ComboModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;
  final double offer;
  final int quantity;
  final String status;
  final List<ComboProduct> products;
  final DateTime createdAt;
  final DateTime updatedAt;

  ComboModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.offer,
    required this.quantity,
    required this.status,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ComboModel.fromJson(Map<String, dynamic> json) {
    return ComboModel(
      id: json['_id'],
      name: json['ccName'],
      description: json['ccDescription'],
      image: json['ccImage'],
      price: (json['ccPrice'] as num).toDouble(),
      offer: (json['ccOffer'] as num).toDouble(),
      quantity: json['ccQuantity'],
      status: json['ccStatus'],
      products: (json['ccProducts'] as List)
          .map((product) => ComboProduct.fromJson(product))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class ComboProduct {
  final String id;
  final String productId;
  final ProductVariant variant;

  ComboProduct({
    required this.id,
    required this.productId,
    required this.variant,
  });

  factory ComboProduct.fromJson(Map<String, dynamic> json) {
    return ComboProduct(
      id: json['_id'],
      productId: json['product'],
      variant: ProductVariant.fromJson(json['variant']),
    );
  }
}

class ProductVariant {
  final String id;
  final String size;
  final String type;
  final double price;

  ProductVariant({
    required this.id,
    required this.size,
    required this.type,
    required this.price,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['_id'],
      size: json['size'],
      type: json['type'],
      price: (json['price'] as num).toDouble(),
    );
  }
} 