import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/address/address.dart';

class AddressService {
  static const String apiUrl = "https://backmern.picknow.in/api/user/address";

  Future<bool> postAddress(Address address) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception("No authentication token found.");
      }
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(address.toJson()),
      );
      print('## ${response.statusCode}');
      print('## ${response.body}');
      if (response.statusCode == 201) {
        return true; // Successfully posted
      } else {
        throw Exception("Failed to post address");
      }
    } catch (e) {
      print("Error posting address: $e");
      return false;
    }
  }

  final String baseUrl = "https://backmern.picknow.in/api/user/addresses";

  Future<AddressModel> fetchAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception("No authentication token found.");
    }
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    debugPrint('status ${response.statusCode}');
    debugPrint('status body ${response.body}');
    
    if (response.statusCode == 200) {
      return AddressModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load addresses");
    }
  }
}
