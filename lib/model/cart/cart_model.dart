class CartModel {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double platformFee;
  final double shippingCharges;
  final double finalAmount;

  CartModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.createdAt,
    required this.updatedAt,
    this.platformFee = 0,
    this.shippingCharges = 0,
    this.finalAmount = 0,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'] ?? '',
      userId: json['user'] ?? '',
      items: (json['items'] as List<dynamic>? ?? [])
          .map((item) => CartItem.fromJson(item))
          .toList(),
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      platformFee: (json['platformFee'] as num?)?.toDouble() ?? 0.0,
      shippingCharges: (json['shippingCharges'] as num?)?.toDouble() ?? 0.0,
      finalAmount: (json['finalAmount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class CartItem {
  final String? productId;
  final String? name;
  final double? price;
  final int quantity;
  final List<String>? images;
  final int? stock;
  final String? quantityInfo;
  final int tax;
  final int offer;
  final String? variantType;
  final String? variantValue;
  final String? variantId;
  final ProductDetails? product;

  CartItem({
    this.productId,
    this.name,
    this.price,
    required this.quantity,
    this.images,
    this.stock,
    this.quantityInfo,
    this.tax = 0,
    this.offer = 0,
    this.variantType,
    this.variantValue,
    this.variantId,
    this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['product']?['_id'],
      name: json['product']?['pName'],
      price: json['price']?.toDouble() ?? json['product']?['pPrice']?.toDouble(),
      quantity: json['quantity'] ?? 1,
      images: (json['product']?['pImage'] as List<dynamic>?)?.cast<String>(),
      stock: json['product']?['pStock'],
      quantityInfo: json['variantValue'],
      tax: json['tax'] ?? 0,
      offer: json['offer'] ?? json['product']?['pOffer'] ?? 0,
      variantType: json['variantType'],
      variantValue: json['variantValue'],
      variantId: json['variantId'],
      product: json['product'] != null ? ProductDetails.fromJson(json['product']) : null,
    );
  }
}

class ProductDetails {
  final String id;
  final String name;
  final double price;
  final String quantity;
  final int stock;
  final List<String> images;
  final int offer;

  ProductDetails({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.stock,
    required this.images,
    required this.offer,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['_id'] ?? '',
      name: json['pName'] ?? '',
      price: (json['pPrice'] as num?)?.toDouble() ?? 0.0,
      quantity: json['pQuantity'] ?? '',
      stock: json['pStock'] ?? 0,
      images: (json['pImage'] as List<dynamic>?)?.cast<String>() ?? [],
      offer: json['pOffer'] ?? 0,
    );
  }
}

class CartResponse {
  final bool success;
  final CartModel cart;

  CartResponse({required this.success, required this.cart});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      success: json['success'] ?? false,
      cart: CartModel.fromJson(json['cart'] ?? {}),
    );
  }
}
