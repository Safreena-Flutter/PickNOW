// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:picknow/costants/theme/appcolors.dart';
import 'package:picknow/views/products/detailed_page.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import '../../providers/product/product_list_provider.dart';
import '../../model/products/product_list_model.dart';
import '../../providers/reviewproviders/review_provider.dart';
import '../../providers/whishlist/whishlist_provider.dart';

class ProductsGridview extends StatefulWidget {
  final String? categoryId;
  final String? brandId;
  final String? categoryname;
  final bool? isfromcatogory;
  final bool? isfrombrand;

  const ProductsGridview(
      {super.key,
      this.categoryId,
      this.categoryname,
      this.isfromcatogory,
      this.isfrombrand,
      this.brandId});

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
      print('categoryid ${widget.categoryname}');
      print('categorybrand ${widget.brandId}');
      widget.isfrombrand == true
          ? context
              .read<ProductListProvider>()
              .fetchbrandProducts(brandId: widget.brandId!)
          : widget.isfromcatogory == true
              ? context.read<ProductListProvider>().fetchProducts(
                    categoryId: widget.categoryId!,
                    refresh: true,
                  )
              : context
                  .read<ProductListProvider>()
                  .fetchcategoryProducts(categoryname: widget.categoryname!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductListProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading && provider.products.isEmpty) {
          return _buildShimmerGrid();
        }
        final validProducts = provider.products
            .where((p) => p.variantDetails?.price != null)
            .toList();
        if (validProducts.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                "No products available",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          );
        }

        return CustomScrollView(
          controller: _scrollController,
          shrinkWrap: true,
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
                  childAspectRatio: 0.60,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = validProducts[index];
                    return _buildProductCard(product);
                  },
                  childCount: validProducts.length,
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
                      if ((product.variantDetails?.offer) != 0)
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
                              '${product.variantDetails?.offer}% OFF',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.pBrand,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                            if (reviewProvider.totalReviews.toString() != '0')
                              Row(children: [
                                Container(
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.green, size: 10),
                                      SizedBox(
                                        width: 1,
                                      ),
                                      Text(
                                        reviewProvider.averageRating.toString(),
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 10,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  '(${reviewProvider.totalReviews.toString()})',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                )
                              ]),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rs.${product.variantDetails?.price}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                            if (product.variantDetails?.previousPrice != 0)
                              Text(
                                'Rs.${product.variantDetails?.previousPrice}',
                                style: TextStyle(
                                  fontSize: 11,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey[600],
                                ),
                              ),
                            Text(
                              product.variantDetails?.size ?? '',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.orange, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 26.0, right: 26, top: 5, bottom: 5),
                                child: Text(
                                  'Add to cart',
                                  style: TextStyle(
                                      color: AppColors.darkblue,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Builder(
                              builder: (context) {
                                final wishlistProvider =
                                    Provider.of<WishlistProvider>(context,
                                        listen: false);
                                bool isWishlisted =
                                    wishlistProvider.isWishlisted(product.id);
                                bool isLoading =
                                    wishlistProvider.isLoading(product.id);

                                return GestureDetector(
                                  onTap: () {
                                    final variantId =
                                        product.variantDetails?.id ??
                                            product.id;
                                    wishlistProvider.toggleWishlist(
                                        product.id, variantId);
                                  },
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 25,
                                          height: 25,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Icon(
                                          isWishlisted
                                              ? Icons.favorite
                                              : Icons.favorite,
                                          size: 27,
                                          color: isWishlisted
                                              ? Colors.red
                                              : Colors.grey.withOpacity(0.6),
                                        ),
                                );
                              },
                            ),
                          ],
                        )
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
