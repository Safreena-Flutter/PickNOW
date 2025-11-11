// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:picknow/costants/navigation/navigation.dart';
import 'package:picknow/views/combo/combo_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../costants/theme/appcolors.dart';
import '../../../providers/whishlist/whishlist_provider.dart';
import '../../products/detailed_page.dart';

class FeaturedProductsList extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final bool? from;
  const FeaturedProductsList({super.key, required this.products, this.from});

  @override
  Widget build(BuildContext context) {
    double containerHeight =
        MediaQuery.of(context).size.height * (from == true ? 0.40 : 0.39);
    return SizedBox(
      height: containerHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: products.isEmpty ? 3 : products.length,
        itemBuilder: (context, index) {
          if (products.isEmpty) {
            return _buildShimmerCard(context);
          }
          final product = products[index];
          return ProductCard(
            iscombo: from ?? false,
            id: product['id'],
            offer: product['offer'],
            productName: product['name'],
            productWeight: product['weight'],
            price: product['price'],
            originalPrice: product['originalPrice'],
            imageUrl: product['imageUrl'],
            varientid: product['varientid'],
            brand: product['brand'],
          );
        },
      ),
    );
  }

  Widget _buildShimmerCard(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageHeight = screenWidth * 0.45;
    double cardWidth = screenWidth * 0.45;

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmer for image
              Container(
                height: imageHeight,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shimmer for product name
                    Container(
                      width: double.infinity,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Shimmer for weight
                    Container(
                      width: 60,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Shimmer for price row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String id;
  final String productName;
  final String productWeight;
  final int price;
  final int originalPrice;
  final String imageUrl;
  final String? rating;
  final String? reviews;
  final int offer;
  final bool iscombo;
  final String varientid;
  final String? brand;

  const ProductCard({
    super.key,
    required this.id,
    required this.iscombo,
    required this.productName,
    required this.productWeight,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.offer,
    required this.varientid,
    this.brand,
    this.rating,
    this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageHeight = screenWidth * 0.45;
    double cardWidth = screenWidth * 0.45;

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: GestureDetector(
        onTap: () {
          iscombo
              ? PageNavigations().push(ComboDetailScreen(
                  comboId: id,
                ))
              : PageNavigations().push(PremiumProductDetailPage(
                  id: id,
                ));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.network(
                    imageUrl,
                    height: imageHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: imageHeight,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: imageHeight,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: const Icon(Icons.error_outline),
                      );
                    },
                  ),
                ),
                if (offer != 0)
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade700,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                            offset: const Offset(1, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '$offer% OFF',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
              ]),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (brand!.isNotEmpty)
                          Text(
                            brand ?? '',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 12),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹$price',
                          style: TextStyle(
                            color: Colors.green[800],
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        originalPrice != 0
                            ? Text(
                                '₹$originalPrice',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12,
                                ),
                              )
                            : SizedBox.shrink(),
                        if (productWeight != "1")
                          Text(
                            productWeight,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.orange, width: 1.5),
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
                                wishlistProvider.isWishlisted(varientid);
                            bool isLoading =
                                wishlistProvider.isLoading(varientid);

                            return GestureDetector(
                              onTap: () {
                                final variantId = varientid;
                                wishlistProvider.toggleWishlist(id, variantId);
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
      ),
    );
  }
}
