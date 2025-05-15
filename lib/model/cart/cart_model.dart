class CartItem {
  final String id;
  final String name;
  final double price;
  final String weight;
  final int stock;
  final List<String> images;
  final double discountPercentage;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.weight,
    required this.stock,
    required this.images,
    required this.discountPercentage,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['product']['_id'],
      name: json['product']['pName'],
      price: (json['product']['pPrice'] as num).toDouble(),
      weight: json['product']['pQuantity']?.toString() ?? '',
      stock: json['product']['pStock'],
      images: List<String>.from(json['product']['pImage']),
      discountPercentage: double.tryParse(json['product']['pOffer']?.toString() ?? '0') ?? 0,
      quantity: json['quantity'],
    );
  }
}

class CartModel {
  final String id;
  final String userId;
  final List<CartItem> items;
  final String paymentId;
  final double totalAmount;
  final DateTime createdAt;
  final DateTime updatedAt;

  CartModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.paymentId,
    required this.totalAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'],
      userId: json['user'],
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      paymentId: json['PaymentId'],
      totalAmount: (json['totalAmount'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class CartResponse {
  final bool success;
  final CartModel cart;

  CartResponse({required this.success, required this.cart});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      success: json['success'],
      cart: CartModel.fromJson(json['cart']),
    );
  }
}
