import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/category/category_model.dart';

class SubCategoryService {
  Future<List<SubCategory>> fetchSubCategories(String categoryId) async {
    final url =
        "https://backmern.picknow.in/api/category/$categoryId/subcategories";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["success"] == true) {
          List<dynamic> subCategoryList = [];
          for (var category in data["subCategories"]) {
            subCategoryList.addAll(category["subCategories"]);
          }
          return _parseSubCategories(subCategoryList);
        } else {
          throw Exception("Failed to load subcategories");
        }
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  /// **Helper function to parse JSON list into SubCategory objects**
  List<SubCategory> _parseSubCategories(List<dynamic> jsonList) {
    return jsonList.map((json) {
      return SubCategory(
        id: json["_id"],
        name: json["name"],
        description: json['description'],
        image: json["image"].startsWith("http")
            ? json["image"]
            : "https://res.cloudinary.com/dnwxrqvth/image/upload/${json["image"]}",
      );
    }).toList();
  }
}
