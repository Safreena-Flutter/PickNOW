class Address {
  final String type;
  final String street;
  final String city;
  final String state;
  final String pincode;
  final String country;

  Address({
    required this.type,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "street": street,
      "city": city,
      "state": state,
      "pincode": pincode,
      "country": country,
    };
  }
}
class AddressModel {
  final bool success;
  final List<AllAddress> addresses;

  AddressModel({required this.success, required this.addresses});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      success: json['success'] ?? false,
      addresses: (json['addresses'] as List<dynamic>?)
              ?.map((x) => AllAddress.fromJson(x))
              .toList() ??
          [],
    );
  }
}

class AllAddress {
  final String id;
  final String? userId; // Nullable, if not present in response
  final String? name;
  final String? phone;
  final String address;
  final String city;
  final String state;
  final String country;
  final String pincode;
  final bool isDefault;

  AllAddress({
    required this.id,
    this.userId,
    this.name,
    this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    required this.isDefault,
  });

  factory AllAddress.fromJson(Map<String, dynamic> json) {
    return AllAddress(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '', // Default empty if null
      name: json['name'] ?? 'Unknown',
      phone: json['phone'] ?? '',
      address: json['street'] ?? 'Unknown Address', // `street` is used instead of `address`
      city: json['city'] ?? 'Unknown City',
      state: json['state'] ?? 'Unknown State',
      country: json['country'] ?? 'Unknown Country',
      pincode: json['pincode'] ?? '000000',
      isDefault: json['isDefault'] ?? false,
    );
  }
}
