import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String _profileImageKey = "profile_image";

  static Future<void> saveProfileImage(String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileImageKey, imageUrl);
  }

  static Future<String> getProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_profileImageKey) ??
        "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg"; // Default image
  }
}
