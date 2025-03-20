import 'package:flutter/material.dart';
import '../../model/profile/userprofile_model.dart';
import '../../services/profile/profile_service.dart';

class ProfileProvider with ChangeNotifier {
  ProfileModel? _user;
  bool _isUpdating = false;
  bool _isLoading = false;
  String? _error;

  ProfileModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isUpdating => _isUpdating;

  final ProfileService _userService = ProfileService();

  Future<void> loadUserProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await _userService.fetchUserProfile();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> updateUserProfile(
      String name, String email, String contact) async {
    _isUpdating = true;
    _error = null;
    notifyListeners();

    try {
      bool success = await _userService.updateProfile(name, email, contact);
      _isUpdating = false;
      if (success) {
        loadUserProfile();
      }
      notifyListeners();

      return success;
    } catch (e) {
      _error = e.toString();
      _isUpdating = false;
      notifyListeners();
      return false;
    }
  }
}
