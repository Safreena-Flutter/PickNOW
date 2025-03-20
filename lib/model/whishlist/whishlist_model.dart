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

  WishlistProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.brand,
    required this.inStock,
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
    );
  }
}
