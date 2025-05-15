
class Combo {
  String id;
  String ccName;
  String ccDescription;
  String ccImage;
  int ccPrice;
  int ccOffer;
  int ccQuantity;
  String ccStatus;
  List<Map<String, dynamic>> ccProducts;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Combo({
    required this.id,
    required this.ccName,
    required this.ccDescription,
    required this.ccImage,
    required this.ccPrice,
    required this.ccOffer,
    required this.ccQuantity,
    required this.ccStatus,
    required this.ccProducts,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Combo.fromJson(Map<String, dynamic> json) {
    return Combo(
      id: json['_id'],
      ccName: json['ccName'],
      ccDescription: json['ccDescription'],
      ccImage: json['ccImage'],
      ccPrice: json['ccPrice'],
      ccOffer: json['ccOffer'],
      ccQuantity: json['ccQuantity'],
      ccStatus: json['ccStatus'],
      ccProducts: List<Map<String, dynamic>>.from(json['ccProducts'].map((x) => x)),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}
