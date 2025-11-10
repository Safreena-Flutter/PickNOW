class Brand {
  final String id;
  final String logo;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Brand({
    required this.id,
    required this.logo,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['_id'] ?? '',
      logo: json['logo'] ?? '',
      name: json['name'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'logo': logo,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}
