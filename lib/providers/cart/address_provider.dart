import 'package:flutter/material.dart';
import '../../model/address/address.dart';
import '../../services/cart/address_service.dart';
class AddressProvider with ChangeNotifier {
  bool _isPosting = false;
  String _message = "";

  bool get isPosting => _isPosting;
  String get message => _message;

  final AddressService _addressService = AddressService();

  Future<void> submitAddress(Address address) async {
    _isPosting = true;
    _message = "";
    notifyListeners();

    bool success = await _addressService.postAddress(address);

    _isPosting = false;
    _message = success ? "Address submitted successfully!" : "Failed to submit address";
    notifyListeners();
  }


  List<AllAddress> _addresses = [];
  bool _isLoading = false;

  List<AllAddress> get addresses => _addresses;
  bool get isLoading => _isLoading;


  Future<void> loadAddresses() async {
    _isLoading = true;
    notifyListeners();

    try {
      AddressModel addressModel = await _addressService.fetchAddresses();
      _addresses = addressModel.addresses;
    } catch (e) {
      _addresses = [];
      print("Error fetching addresses: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}

