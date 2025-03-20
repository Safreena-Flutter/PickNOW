import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/whishlist/whishlist_model.dart';

class WishlistService {
  Future<WishlistModel> addToWishlist(String productId) async {
    final url = Uri.parse("https://backmern.picknow.in/api/user/wishlist/$productId");

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        return WishlistModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to add product to wishlist');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
