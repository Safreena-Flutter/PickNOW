// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:picknow/core/costants/api/baseurl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/authentication/register.dart';

class RegisterService {
  Future<UserModel> registerUser(Map<String, String> userData) async {
    try {
      final response = await http.post(
        Uri.parse(registerurl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      final jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonData);

        // Store token in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', user.activationToken);

        return user;
      } else {
        // Extract and show the error message in a toast
        String errorMessage = jsonData['message'] ?? 'Failed to register';
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );

    throw Exception(errorMessage); 
      }
    } catch (e) {
    throw Exception('Error: $e');
    }
  }

  Future<String> verifyOtp(String activationToken, String otp) async {
    try {
      final response = await http.post(
        Uri.parse(otpverify),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $activationToken',
        },
        body: jsonEncode({"otp": otp}),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', jsonData['token']);

        return jsonData['message'];
      } else {
        throw Exception('Invalid OTP');
      }
    } catch (e) {
      throw Exception('Error verifying OTP: $e');
    }
  }

  Future<UserModel> resendOtp(String email) async {
    try {
      final response = await http.post(
        Uri.parse(resendotp), // Use correct resend OTP URL
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"email": email}),
      );

      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        UserModel user = UserModel.fromJson(jsonData);

        // Store token in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', user.activationToken);
        return user;
      } else {
        throw Exception('Invalid email');
      }
    } catch (e) {
      throw Exception('Error in resending OTP: $e');
    }
  }
}
