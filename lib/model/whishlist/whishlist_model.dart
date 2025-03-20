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
