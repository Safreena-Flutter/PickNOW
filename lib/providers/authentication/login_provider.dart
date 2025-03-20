import 'package:flutter/material.dart';
import 'package:picknow/services/authentication/login_service.dart';
import '../../core/costants/api/baseurl.dart';
import '../../model/authentication/login_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginProvider extends ChangeNotifier {
  final LoginService _authService = LoginService();
  AuthResponse? _user;
  bool _isLoading = false;

  AuthResponse? get user => _user;
  bool get isLoading => _isLoading;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _authService.loginUser(email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(forgotpassword);
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );

    _isLoading = false;
    notifyListeners();
    debugPrint('responsestatuscode ${response.statusCode}');
    debugPrint('responsebody ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> resetPassword({
    required String email,
    required String resetToken,
    required String newPassword,
  }) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(resetpassword);
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "resetToken": resetToken,
        "newPassword": newPassword,
      }),
    );

    _isLoading = false;
    notifyListeners();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
