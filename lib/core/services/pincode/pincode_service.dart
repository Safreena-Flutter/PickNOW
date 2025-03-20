import 'dart:convert';
import 'package:http/http.dart' as http;
class PincodeService {
  // Replace with your API endpoint
  static const String _apiUrl = "https://api.postalpincode.in/pincode/";

  // Function to fetch city and state
  static Future<Map<String, String>> getCityState(String pincode) async {
    try {
      final response = await http.get(Uri.parse(_apiUrl + pincode));

      if (response.statusCode == 200) {
        // Parse the JSON response
        final data = json.decode(response.body);

        if (data[0]['Status'] == 'Success') {
          final postOffice = data[0]['PostOffice'][0];
          return {
            'city': postOffice['District'],
            'state': postOffice['State'],
          };
        } else {
          throw Exception('Pincode not found');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
