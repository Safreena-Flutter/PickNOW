// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:picknow/core/costants/mediaquery/mediaquery.dart';
import 'package:picknow/core/costants/navigation/navigation.dart';
import 'package:picknow/core/costants/theme/appcolors.dart';
import 'package:provider/provider.dart';

import '../../../providers/whishlist/whishlist_provider.dart';
import '../../products/detailed_page.dart';

class FeaturedProductsList extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final bool? from;
  const FeaturedProductsList({super.key, required this.products, this.from});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: from == true
          ? mediaqueryheight(0.332, context)
          : mediaqueryheight(0.37, context),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            id: product['id'],
              offer: product['offer'],
              productName: product['name'],
              productWeight: product['weight'],
              price: product['price'],
              originalPrice: product['originalPrice'],
              imageUrl: product['imageUrl'],
              );
        },
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

  const ProductCard({
    super.key,
    required this.id,
    required this.productName,
    required this.productWeight,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.offer,
    this.rating,
    this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaquerywidth(0.4, context),
      margin: const EdgeInsets.only(left: 4),
      child: GestureDetector(
        onTap: () {
          PageNavigations().push(PremiumProductDetailPage(
            id: id,
          ));
        },
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.grey.withOpacity(0.1))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: Image.network(
                      imageUrl,
                      height: mediaqueryheight(0.2, context),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child:  Consumer<WishlistProvider>(
                            builder: (context, wishlistProvider, child) {
                              bool isWishlisted =
                                  wishlistProvider.isWishlisted(id);
                              bool isLoading = wishlistProvider.isLoading(id); // Get loading state for this product

                              return GestureDetector(
                                onTap: () {
                                  wishlistProvider.toggleWishlist(id);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productName,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              productWeight != "1"
                                  ? Text(
                                      productWeight,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    rating != null && reviews != null
                        ? Row(
                            children: const [
                              Icon(Icons.star,
                                  color: Colors.blueGrey, size: 20),
                              SizedBox(width: 4),
                              Text('4.5'),
                            ],
                          )
                        : SizedBox.shrink(),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹$price',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₹$originalPrice',
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        offer != 0
                            ? Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.green.withOpacity(0.1),
                                ),
                                child: Text(
                                  '$offer% Off',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.green[600],
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : SizedBox.shrink(),
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
