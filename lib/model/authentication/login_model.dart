class LoginModel {   
  final String id;
  final String name;
  final String email;
  final String role;
  final String contact;
  final bool isVerified;
  final String? resetPasswordToken;
  final String? resetPasswordExpires;
  final String createdAt;
  final String updatedAt;

  LoginModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.contact,
    required this.isVerified,
    this.resetPasswordToken,
    this.resetPasswordExpires,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      role: json["role"],
      contact: json["contact"],
      isVerified: json["isVerified"],
      resetPasswordToken: json["resetPasswordToken"],
      resetPasswordExpires: json["resetPasswordExpires"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }
}

class AuthResponse {
  final String message;
  final String token;
  final LoginModel user;

  AuthResponse({
    required this.message,
    required this.token,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      message: json["message"],
      token: json["token"],
      user: LoginModel.fromJson(json["user"]),
    );
  }
}
