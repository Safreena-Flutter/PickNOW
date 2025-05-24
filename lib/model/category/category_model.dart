class CategoryModel {
  final String id;
  final String name;
  final String description;
  final List<String> images;
  final String status;
  final int products;
  final List<SubCategory> subCategories;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.status,
    required this.products,
    required this.subCategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? '',
      name: json['cName'] ?? '',
      description: json['cDescription'] ?? '',
      images: json['cImage'] != null
          ? List<String>.from(json['cImage'])
          : [],
      status: json['cStatus'] ?? '',
      products: json['products'] ?? 0,
      subCategories: json['subCategories'] != null
          ? (json['subCategories'] as List)
              .map((subCat) => SubCategory.fromJson(subCat))
              .toList()
          : [],
    );
  }
}

class SubCategory {
  final String id;
  final String name;
  final String description;
  final String image;
  final String status;
  final List<SubSubCategory> subCategories;

  SubCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.status,
    required this.subCategories,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? '',
      subCategories: json['subCategories'] != null
          ? (json['subCategories'] as List)
              .map((subSubCat) => SubSubCategory.fromJson(subSubCat))
              .toList()
          : [],
    );
  }
}

class SubSubCategory {
  final String id;
  final String name;
  final String description;
  final String image;
  final String status;

  SubSubCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.status,
  });

  factory SubSubCategory.fromJson(Map<String, dynamic> json) {
    return SubSubCategory(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class CategoryResponse {
  final bool success;
  final List<CategoryModel> data;

  CategoryResponse({
    required this.success,
    required this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      success: json['success'],
      data: (json['data'] as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList(),
    );
  }
}
