import 'package:flutter/material.dart';
import '../../model/authentication/register.dart';
import '../../services/authentication/register_service.dart';

class AuthProvider with ChangeNotifier {
  final RegisterService _registerService = RegisterService();
  bool _isLoading = false;
  String? _activationToken;
  bool _isVerifying = false;
  String? _message;

  bool get isVerifying => _isVerifying;
  String? get message => _message;

  bool get isLoading => _isLoading;
  String? get activationToken => _activationToken;

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String contact,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      UserModel user = await _registerService.registerUser({
        "name": name,
        "email": email,
        "password": password,
        "contact": contact,
      });

      _activationToken = user.activationToken;
    } catch (e) {
      _activationToken = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> verifyOtp(String activationToken, String otp) async {
    _isVerifying = true;
    notifyListeners();

    try {
      _message = await _registerService.verifyOtp(activationToken, otp);
      _isVerifying = false;
      notifyListeners();
      return true; // Successful verification
    } catch (e) {
      _message = e.toString();
      _isVerifying = false;
      notifyListeners();
      return false; // OTP verification failed
    }
  }

  Future<void> resentotp({required String email}) async {
  _isLoading = true;
  notifyListeners();

  try {
    UserModel user = await _registerService.resendOtp(email);

    _activationToken = user.activationToken;
    notifyListeners();
    } catch (e) {
    _activationToken = null;
    notifyListeners();
  }

  _isLoading = false;
  notifyListeners();
}
}
