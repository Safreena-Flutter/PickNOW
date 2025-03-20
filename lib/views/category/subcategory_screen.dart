// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:picknow/core/costants/mediaquery/mediaquery.dart';
import 'package:picknow/core/costants/navigation/navigation.dart';
import 'package:picknow/views/home/widgets/title.dart';
import 'package:picknow/views/products/gird_view.dart';
import 'package:picknow/views/widgets/customappbar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../providers/category/sub_category.dart';
import '../products/products_gridview.dart';

class SubCategoryScreen extends StatefulWidget {
  final String categoryId;
  final String title;
  const SubCategoryScreen(
      {super.key, required this.categoryId, required this.title});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SubCategoryProvider>(context, listen: false)
        .loadSubCategories(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SubCategoryProvider>(context);
    final subCategories = provider.subCategories;

    return Scaffold(
  appBar: customAppbar(context, widget.title),
  body: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        provider.isLoading
            ? _buildShimmerGrid() // Keep shimmer as it is
            : subCategories.isEmpty
                ? const Center(child: Text("No subcategories found"))
                : Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
                    child: SizedBox(
                      height: 140, // Fix height for horizontal ListView
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: subCategories.length,
                        itemBuilder: (context, index) {
                          final subCategory = subCategories[index];
                          return _buildSubCategoryCard(subCategory);
                        },
                      ),
                    ),
                  ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: buildSectionTitle('Recommended Products'),
        ),
        const SizedBox(height: 8),
        SizedBox(
          //height: MediaQuery.of(context).size.height * 0.9, // Define height
          child: ProductsGridview(
            categoryname: widget.title,
            isfromcatogory: false,
           
          ),
        ),
      ],
    ),
  ),
);

  }

  /// **SubCategory Card**
  Widget _buildSubCategoryCard(subCategory) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
         onTap: () => PageNavigations().push(Productsview(
          categoryid:subCategory.id ,
        name: subCategory.name,
         )) ,
        child: AnimatedContainer(
          width: mediaquerywidth(0.35, context),
          duration: const Duration(seconds: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.transparent,
              width: 2,
            ),
            gradient: LinearGradient(
              colors: [
                Colors.orange,
                Colors.deepOrange,
                Colors.amber,
                Colors.orange
              ],
              stops: [0.0, 0.5, 1.0, 0.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              tileMode: TileMode.mirror,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                // Subcategory Image
                Positioned.fill(
                  child: Image.network(
                    subCategory.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image_not_supported_outlined,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                ),
        
                // Name Overlay on top of the image
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black
                          .withOpacity(0.3), // Semi-transparent background
                    ),
                    child: Text(
                      subCategory.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white, // White text for better visibility
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, // Avoid overflow issues
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// **Shimmer Loading Effect**
  Widget _buildShimmerGrid() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: 6, // Number of shimmer items
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!, width: 2),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
