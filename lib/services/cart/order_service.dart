import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:picknow/model/address/address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {
  final String baseUrl = "https://backmern.picknow.in/api";

  Future<bool> placeOrder(Address address, String paymentId, String orderNotes) async {
    final url = Uri.parse('$baseUrl/order/order/cart');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    final body = {
      "shippingAddress": {
        "street": address.street,
        "city": address.city,
        "state": address.state,
        "pincode": address.pincode,
        "country": address.country,
      },
      "PaymentId": paymentId,
      "orderNotes": orderNotes,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json",
        "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );
print('*** ${response.statusCode}');
print('*** ${response.body}');
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        print("Order API Error: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Order API Exception: $e");
      return false;
    }
  }
}
