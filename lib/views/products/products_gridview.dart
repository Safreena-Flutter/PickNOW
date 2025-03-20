// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:picknow/core/costants/theme/appcolors.dart';
import 'package:picknow/views/products/detailed_page.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import '../../providers/product/product_list_provider.dart';
import '../../model/products/product_list_model.dart';
import '../../providers/reviewproviders/review_provider.dart';
import '../../providers/whishlist/whishlist_provider.dart';

class ProductsGridview extends StatefulWidget {
  final String? categoryId;
  final String? categoryname;
  final bool? isfromcatogory;

  const ProductsGridview(
      {super.key, this.categoryId, this.categoryname, this.isfromcatogory});

  @override
  State<ProductsGridview> createState() => _ProductsGridviewState();
}

class _ProductsGridviewState extends State<ProductsGridview> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_onScroll);
    _loadProducts();
  }

  void _loadProducts() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.isfromcatogory == true
          ? context.read<ProductListProvider>().fetchProducts(
                categoryId: widget.categoryId!,
                refresh: true,
              )
          : context
              .read<ProductListProvider>()
              .fetchcategoryProducts(categoryname: widget.categoryname!);
    });
  }

  // void _onScroll() {
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     context.read<ProductListProvider>().fetchProducts(
  //           categoryId: widget.categoryId,
  //         );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductListProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading && provider.products.isEmpty) {
          return _buildShimmerGrid();
        }

        return CustomScrollView(
          controller: _scrollController,
          //  physics: widget.isfromcatogory == true ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(), // Disable inner scrolling
          //    physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
          shrinkWrap: true, // Ensures it takes only needed space
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 1200
                      ? 4
                      : MediaQuery.of(context).size.width > 800
                          ? 3
                          : 2,
                  childAspectRatio: 0.68,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index >= provider.products.length) {
                      return _buildShimmerCard();
                    }
                    final product = provider.products[index];
                    return _buildProductCard(product);
                  },
                  childCount: provider.hasMore
                      ? provider.products.length
                      : provider.products.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductCard(Product product) {
    return ChangeNotifierProvider(
      create: (context) => ReviewProvider()
        ..fetchReviews(product.id), // Fetch reviews on creation
      child: Consumer<ReviewProvider>(
        builder: (context, reviewProvider, child) {
          return Container(
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.all(color: AppColors.grey.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(4)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PremiumProductDetailPage(id: product.id),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          child: Image.network(
                            product.pImage.first
                                .replaceAll("httplocalhost:5000/uploads/", ""),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.grey[200],
                              child: Icon(Icons.image_not_supported,
                                  color: Colors.grey[400]),
                            ),
                          ),
                        ),
                      ),
                      if (product.pOffer != "0")
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green[500],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${product.pOffer}% OFF',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                          top: 8,
                          right: 8,
                          child: Consumer<WishlistProvider>(
                            builder: (context, wishlistProvider, child) {
                              bool isWishlisted =
                                  wishlistProvider.isWishlisted(product.id);
                              bool isLoading = wishlistProvider.isLoading(product
                                  .id); // Get loading state for this product

                              return GestureDetector(
                                onTap: () {
                                  wishlistProvider.toggleWishlist(product.id);
                                },
                                child: isLoading
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Icon(
                                        isWishlisted
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isWishlisted
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                              );
                            },
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.pName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              'Rs.${product.pPrice.toString()}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                            if (product.pPreviousPrice != 0) ...[
                              const SizedBox(width: 4),
                              Text(
                                'Rs.${product.pPreviousPrice.toString()}',
                                style: TextStyle(
                                  fontSize: 12,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            // Star Rating Display
                            Row(
                              children: List.generate(5, (index) {
                                double rating = reviewProvider.averageRating;
                                if (rating == 0.0) {
                                  return Icon(Icons.star_border,
                                      color: Colors.amber, size: 16);
                                } else if (index < rating.floor()) {
                                  return Icon(Icons.star,
                                      color: Colors.amber, size: 16);
                                } else if (index < rating) {
                                  return Icon(Icons.star_half,
                                      color: Colors.amber, size: 16);
                                } else {
                                  return Icon(Icons.star_border,
                                      color: Colors.amber, size: 16);
                                }
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 1200
            ? 4
            : MediaQuery.of(context).size.width > 800
                ? 3
                : 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 8,
        mainAxisSpacing: 12,
      ),
      itemCount: 8,
      itemBuilder: (_, __) => _buildShimmerCard(),
    );
  }

  Widget _buildShimmerCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
              ),
            ),
            // Content placeholders
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 14,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 100,
                    height: 14,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 14,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 40,
                        height: 14,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
