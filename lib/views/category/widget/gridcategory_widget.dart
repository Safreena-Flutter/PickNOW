// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:picknow/core/costants/mediaquery/mediaquery.dart';
import 'package:picknow/core/costants/navigation/navigation.dart';
import '../../../core/costants/theme/appcolors.dart';
import '../../../model/category/category_model.dart';
import '../../products/gird_view.dart';

Widget buildSubCategoryCard(SubCategory subCategory, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // SubCategory Name as Heading
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          subCategory.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: subCategory.subCategories!.map((nestedSub) {
            debugPrint("nestedSub.image ${nestedSub.image}");
            debugPrint("nestedSub.id ${nestedSub.id}");
            return Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: GestureDetector(
                onTap: () {
                  PageNavigations().push(Productsview(
                    categoryid: nestedSub.id,
                    name: nestedSub.name,
                  ));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      height: mediaquerySize(0.15, context),
                      width: mediaquerySize(0.15, context),
                      child: ClipOval(
                        child: Image.network(
                          nestedSub.image,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: Colors.grey[200],
                            child: Icon(Icons.image, color: Colors.grey[400]),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // SubSubCategory Name
                    SizedBox(
                      width: mediaquerywidth(0.2, context),
                      child: Text(
                        nestedSub.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Divider(
          color: AppColors.grey.withOpacity(0.2),
        ),
      )
    ],
  );
}
