import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/profile/userprofile_model.dart';

class ProfileService {
  final String profileUrl = "https://backmern.picknow.in/api/user/profile";

  Future<ProfileModel?> fetchUserProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception("No authentication token found.");
      }
debugPrint('token $token');
      final response = await http.get(
        Uri.parse(profileUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Attach token to request
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ProfileModel.fromJson(jsonData);
      } else {
        throw Exception("Failed to load user profile");
      }
    } catch (e) {
      throw Exception("Error fetching user profile: $e");
    }
  }
  final String updateProfileUrl = "https://backmern.picknow.in/api/user/update";

  Future<bool> updateProfile(String name, String email, String contact) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception("No authentication token found.");
      }

      final response = await http.put(
        Uri.parse(updateProfileUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "contact": contact,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to update profile");
      }
    } catch (e) {
      throw Exception("Error updating profile: $e");
    }
  }
}
