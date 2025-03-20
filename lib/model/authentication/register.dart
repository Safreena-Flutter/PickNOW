class UserModel {
  final String message;
  final String activationToken;

  UserModel({required this.message, required this.activationToken});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      message: json['message'],
      activationToken: json['activationToken'],
    );
  }
}
