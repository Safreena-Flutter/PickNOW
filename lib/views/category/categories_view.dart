// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:picknow/costants/mediaquery/mediaquery.dart';
import 'package:picknow/costants/navigation/navigation.dart';
import 'package:picknow/costants/theme/appcolors.dart';
import 'package:picknow/providers/whishlist/whishlist_provider.dart';
import 'package:picknow/views/category/widget/category_iconwidget.dart';
import 'package:picknow/views/category/widget/shimmer_widget.dart';
import 'package:picknow/views/wishlist/wishlist.dart';
import 'package:provider/provider.dart';
import '../../model/category/category_model.dart';
import '../../providers/cart/cart_provider.dart';
import '../../providers/category/all_category.dart';
import '../cart/my_cart.dart';
import 'widget/gridcategory_widget.dart';
import 'widget/sidebar_category.dart';

class CategoryPage extends StatefulWidget {
  final bool isfromhome;
  const CategoryPage({super.key, required this.isfromhome});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectedIndex = 0;
  List<CategoryModel> _activeCategories = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.frost,
        leading: widget.isfromhome
            ? IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  child: const Icon(Icons.arrow_back_ios_rounded, size: 20),
                ),
              )
            : const SizedBox.shrink(),
        title: Text(
          'Shop by Category',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          Consumer<WishlistProvider>(
            builder: (_, wishlist, __) => buildAnimatedIconButton(
              Icons.favorite_border,
              badge: wishlist.wishlist.length.toString(),
              onPressed: () {
                PageNavigations().push(WishlistScreen());
              },
            ),
          ),
          Consumer<CartProvider>(
            builder: (_, cart, __) => buildAnimatedIconButton(
              Icons.shopping_cart_outlined,
              badge: cart.itemCount.toString(),
              onPressed: () {
                PageNavigations().push(ShoppingCart(isfromhome: true));
              },
            ),
          ),
        ],
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          if (categoryProvider.isLoading) {
            return buildShimmerLoading(context);
          }

          if (categoryProvider.error.isNotEmpty) {
            return Center(
              child: Text(
                'Error: ${categoryProvider.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (categoryProvider.categories.isEmpty) {
            return const Center(child: Text('No categories found'));
          }

          // Update active categories list
          _activeCategories = categoryProvider.categories
              .where((cat) => cat.status == 'active')
              .toList();

          // Ensure selected index is valid
          if (_selectedIndex >= _activeCategories.length) {
            _selectedIndex = 0;
          }

          return Row(
            children: [
              _buildCategorySidebar(),
              const VerticalDivider(width: 1, thickness: 0.5),
              _buildCategoryGrid(_activeCategories[_selectedIndex]),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategorySidebar() {
    return Container(
      width: mediaquerywidth(0.24, context),
      color: AppColors.frost,
      child: ListView.builder(
        itemCount: _activeCategories.length,
        itemBuilder: (context, index) {
          final category = _activeCategories[index];
          return buildCategoryNavItem(
            context: context,
            icon: category.images.isNotEmpty
                ? category.images.first
                : 'assets/placeholder.png',
            title: category.name,
            isSelected: _selectedIndex == index,
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildCategoryGrid(CategoryModel selectedCategory) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                selectedCategory.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: selectedCategory.subCategories.length,
                itemBuilder: (context, index) {
                  final subCategory = selectedCategory.subCategories[index];
                  if (subCategory.status == 'active') {
                    return buildSubCategoryCard(subCategory, context);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
