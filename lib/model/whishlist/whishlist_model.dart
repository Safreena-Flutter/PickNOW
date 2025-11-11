class WishlistModel {
  final bool success;
  final String message;

  WishlistModel({required this.success, required this.message});

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      success: json['success'],
      message: json['message'],
    );
  }
}

class WishlistProduct {
  final String id;
  final String name;
  final String description;
  final int price;
  final String image;
  final String brand;
  final bool inStock;
  final String variantId;
  final VariantDetails variant;
  final DateTime addedAt;

  WishlistProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.brand,
    required this.inStock,
    required this.variantId,
    required this.variant,
    required this.addedAt,
  });

  factory WishlistProduct.fromJson(Map<String, dynamic> json) {
    return WishlistProduct(
      id: json["_id"],
      name: json["pName"],
      description: json["pShortDescription"],
      price: json["pPrice"],
      image: json["pImage"],
      brand: json["pBrand"],
      inStock: json["inStock"],
      variantId: json["variantId"],
      variant: VariantDetails.fromJson(json["variant"]),
      addedAt: DateTime.parse(json["addedAt"]),
    );
  }
}

class VariantDetails {
  final String id;
  final String size;
  final String type;
  final int stock;
  final int price;
  final int? previousPrice;
  final int? offer;
  final String status;

  VariantDetails({
    required this.id,
    required this.size,
    required this.type,
    required this.stock,
    required this.price,
    this.previousPrice,
     this.offer,
    required this.status,
  });

  factory VariantDetails.fromJson(Map<String, dynamic> json) {
    return VariantDetails(
      id: json["_id"],
      size: json["size"],
      type: json["type"],
      stock: json["stock"],
      price: json["price"],
      previousPrice: json["previousPrice"] ?? 0,
      offer: json["offer"] ?? 0,
      status: json["status"],
    );
  }
}
