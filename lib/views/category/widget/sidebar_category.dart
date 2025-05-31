// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:picknow/costants/mediaquery/mediaquery.dart';
import 'package:picknow/costants/theme/appcolors.dart';
import 'package:shimmer/shimmer.dart';

Widget buildCategoryNavItem(
    {required String icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    required BuildContext context}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: mediaqueryheight(0.16, context),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: isSelected ? Colors.orange : Colors.transparent,
            width: 5,
          ),
        ),
    
        color: isSelected ? AppColors.frost : AppColors.lightgrey.withOpacity(1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            height: mediaquerySize(0.15, context),
            width: mediaquerySize(0.15, context),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                icon,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: mediaquerySize(0.15, context),
                      width: mediaquerySize(0.15, context),
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.black : Colors.grey[600],
            ),
          ),
        ],
      ),
    ),
  );
}
