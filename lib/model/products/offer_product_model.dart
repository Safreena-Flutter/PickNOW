class OfferProductResponse {
  final bool success;
  final String message;
  final int count;
  final List<Product> data;

  OfferProductResponse({
    required this.success,
    required this.message,
    required this.count,
    required this.data,
  });

  factory OfferProductResponse.fromJson(Map<String, dynamic> json) {
    return OfferProductResponse(
      success: json['success'],
      message: json['message'],
      count: json['count'],
      data: List<Product>.from(json['data'].map((x) => Product.fromJson(x))),
    );
  }
}

class Product {
  final String productId;
  final String variantId;
  final String pName;
  final List<String> pImage;
  final String pDescription;
  final String pCategory;
  final String pBrand;
  final String size;
  final String type;
  final int price;
  final int? previousPrice;
  final int? offer;
  final int stock;

  Product({
    required this.productId,
    required this.variantId,
    required this.pName,
    required this.pImage,
    required this.pDescription,
    required this.pCategory,
    required this.pBrand,
    required this.size,
    required this.type,
    required this.price,
    this.previousPrice,
   this.offer,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      variantId: json['variantId'],
      pName: json['pName'],
      pImage: List<String>.from(json['pImage']),
      pDescription: json['pDescription'],
      pCategory: json['pCategory'],
      pBrand: json['pBrand'],
      size: json['size'],
      type: json['type'],
      price: json['price'],
      previousPrice: json['previousPrice']?? 0,
      offer: json['offer']?? 0,
      stock: json['stock'],
    );
  }
}
