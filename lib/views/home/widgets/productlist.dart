// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:picknow/costants/navigation/navigation.dart';
import 'package:picknow/views/combo/combo_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../providers/whishlist/whishlist_provider.dart';
import '../../products/detailed_page.dart';

class FeaturedProductsList extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final bool? from;
  const FeaturedProductsList({super.key, required this.products, this.from});

  @override
  Widget build(BuildContext context) {
    double containerHeight =
        MediaQuery.of(context).size.height * (from == true ? 0.32 : 0.34);
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
              Stack(
                children: [
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
                  iscombo
                      ? SizedBox.shrink()
                      : Positioned(
                          top: 10,
                          right: 10,
                          child: Consumer<WishlistProvider>(
                            builder: (context, wishlistProvider, child) {
                              bool isWishlisted =
                                  wishlistProvider.isWishlisted(id);
                              bool isLoading = wishlistProvider.isLoading(id);
                              return GestureDetector(
                                onTap: () {
                                  wishlistProvider.toggleWishlist(
                                      id, varientid);
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
                          ),
                        ),
                ],
              ),
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
                    if (productWeight != "1")
                      Text(
                        productWeight,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹$price',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        originalPrice !=0
                      ?  Text(
                          '₹$originalPrice',
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                          ),
                        ): SizedBox.shrink(),
                        if (offer != 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.green.withOpacity(0.1),
                            ),
                            child: Text(
                              '$offer% Off',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green[600],
                                fontWeight: FontWeight.bold,
                              ),
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
