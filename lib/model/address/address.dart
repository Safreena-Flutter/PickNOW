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
