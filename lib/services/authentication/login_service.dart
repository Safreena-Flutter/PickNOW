import 'package:flutter/material.dart';
import 'package:picknow/costants/api/baseurl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../model/authentication/login_model.dart';

class LoginService {
  Future<AuthResponse?> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(loginurl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      debugPrint('responsestatuscode ${response.statusCode}');
      debugPrint('responsebody ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        AuthResponse authResponse = AuthResponse.fromJson(data);

        // Store the token in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        debugPrint('Authtoken :${authResponse.token}');
        await prefs.setString('auth_token', authResponse.token);

        return authResponse;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw "Login failed: $e";
    }
  }
}
