class ProfileModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String contact;
  final bool isVerified;
  final String createdAt;
  final String updatedAt;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.contact,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create an instance from JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['user']['_id'],
      name: json['user']['name'],
      email: json['user']['email'],
      role: json['user']['role'],
      contact: json['user']['contact'],
      isVerified: json['user']['isVerified'],
      createdAt: json['user']['createdAt'],
      updatedAt: json['user']['updatedAt'],
    );
  }
}
