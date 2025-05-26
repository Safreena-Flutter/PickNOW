// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:picknow/core/utils/convert_date.dart';
import 'package:picknow/model/products/product_details_model.dart';
import 'package:picknow/views/products/widget/product_imageview.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:share_plus/share_plus.dart';
import '../../providers/cart/cart_provider.dart';
import '../../providers/combo/combo_provider.dart';
import '../../providers/product/product_detail_provider.dart';
import '../../core/costants/theme/appcolors.dart';
import '../../providers/product/related_products.dart';
import '../../providers/reviewproviders/review_provider.dart';
import '../../providers/whishlist/whishlist_provider.dart';
import '../home/widgets/productlist.dart';
import '../widgets/customappbar.dart';
import 'widget/product_detailwidget.dart';

class PremiumProductDetailPage extends StatefulWidget {
  final String id;
  const PremiumProductDetailPage({
    super.key,
    required this.id,
  });

  @override
  _PremiumProductDetailPageState createState() =>
      _PremiumProductDetailPageState();
}

class _PremiumProductDetailPageState extends State<PremiumProductDetailPage>
    with TickerProviderStateMixin {
  bool _isDetailsExpanded = false;
  bool _isFeaturesExpanded = false;
  bool _isReviewsExpanded = false;
  bool isFavorite = false;
  ComboListProvider comboListProvider = ComboListProvider();
  Variant? selectedVariant;
  int quantity = 1;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ProductDetailProvider>()
          .fetchProductDetails(widget.id)
          .then((_) {
        // Set the default variant when product details are loaded
        final provider = context.read<ProductDetailProvider>();
        if (provider.productDetail != null &&
            provider.productDetail!.product.variants.isNotEmpty) {
          setState(() {
            selectedVariant = provider.productDetail!.product.variants.first;
          });
        }
      });
      Provider.of<RelatedProductProvider>(context, listen: false)
          .fetchRelatedProducts(widget.id);
      Provider.of<ReviewProvider>(context, listen: false)
          .fetchReviews(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return _buildShimmerLoading();
        }

        final product = provider.productDetail!.product;
        if (!provider.productDetail!.success) {
          return Center(child: Text('Product not found'));
        }
        final reviewProvider = Provider.of<ReviewProvider>(context);
        return Scaffold(
          appBar: customAppbar(context, ''),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImageCarousel(
                    images: product.images,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              SizedBox(width: 4),
                              Row(
                                children: List.generate(5, (index) {
                                  double rating = reviewProvider.averageRating;
                                  if (index < rating.floor()) {
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
                              SizedBox(width: 4),
                              Text(
                                '${reviewProvider.averageRating} . ${reviewProvider.totalReviews} ratings',
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₹${selectedVariant?.price ?? product.variants.first.price}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '₹${product.variants.first.previousPrice.toString()}',
                            style: TextStyle(
                              fontSize: 17,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      product.offer != 0
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                '${product.offer}% OFF',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : SizedBox.shrink()
                    ],
                  ),
                  SizedBox(height: 20),
                  if (product.variants.length > 1) ...[
                    Text(
                      'Select Variant',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      children: product.variants.map((variant) {
                        final isSelected = selectedVariant?.id == variant.id;
                        return ChoiceChip(
                          label: Text(variant.size),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              _selectVariant(variant);
                            }
                          },
                          backgroundColor: Colors.grey[200],
                          selectedColor: Colors.green[100],
                          labelStyle: TextStyle(
                            color:
                                isSelected ? Colors.green[800] : Colors.black,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                  ],
                  buildElegantShippingInfo(),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .black87, // Dark text for better readability
                        ),
                      ),
                      SizedBox(height: 20),
                      // Expandable Details Section
                      buildExpandableSection(
                        title: 'Details',
                        icon: Icons.info_outline,
                        isExpanded: _isDetailsExpanded,
                        onTap: () {
                          setState(() {
                            _isDetailsExpanded = !_isDetailsExpanded;
                          });
                        },
                        child: Column(
                          children: [
                            DetailRow(label: 'Brand', value: product.brand),
                            DetailRow(
                                label: 'Net Quantity',
                                value: product.variants.first.size),
                          ],
                        ),
                      ),
                      Divider(
                          height: 30, thickness: 1, color: Colors.grey[200]),
                      // Expandable Features Section
                      buildExpandableSection(
                        title: 'Features',
                        icon: Icons.featured_play_list_outlined,
                        isExpanded: _isFeaturesExpanded,
                        onTap: () {
                          setState(() {
                            _isFeaturesExpanded = !_isFeaturesExpanded;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.shortDescription,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: Colors.grey[800],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              product.description,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                          height: 30, thickness: 1, color: Colors.grey[200]),
                      // Expandable Reviews Section
                      buildExpandableSection(
                        title: 'Reviews',
                        icon: Icons.reviews_outlined,
                        isExpanded: _isReviewsExpanded,
                        onTap: () {
                          setState(() {
                            _isReviewsExpanded = !_isReviewsExpanded;
                          });
                        },
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics:
                              NeverScrollableScrollPhysics(), // Disable scrolling inside ListView
                          padding: EdgeInsets.zero,
                          itemCount: reviewProvider.reviews.length,
                          itemBuilder: (context, index) {
                            final review = reviewProvider.reviews[index];
                            final time =
                                formatDateTimeFromString(review.createdAt);
                            return ReviewCard(
                              username: review.user?.name ?? 'No name',
                              rating: double.parse(review.rating),
                              comment: review.review,
                              date: time,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Similar Products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87, // Dark text for better readability
                    ),
                  ),
                  SizedBox(height: 20),
                  Consumer<RelatedProductProvider>(
                    builder: (context, relatedprovider, child) {
                      if (relatedprovider.isLoading &&
                          relatedprovider.relatedProducts.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (relatedprovider.error != null) {
                        return Center(
                            child: Text('Error: ${relatedprovider.error}'));
                      }
                      final variant = selectedVariant ?? product.variants.first;
                      return FeaturedProductsList(
                        from: false,
                        products: relatedprovider.relatedProducts
                            .map((product) => {
                                  'id': product.id,
                                  'offer': product.offer,
                                  'name': product.name,
                                  'weight': product.quantity,
                                  'price': product.price,
                                  'originalPrice': product.previousPrice,
                                  'imageUrl': product.images.first,
                                  "varientid": variant.id,
                                })
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                // Like and Share Buttons
                Row(
                  children: [
                    Consumer<WishlistProvider>(
                      builder: (context, wishlistProvider, child) {
                        bool isWishlisted =
                            wishlistProvider.isWishlisted(widget.id);
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: () {
                              wishlistProvider.toggleWishlist(
                                  widget.id, product.variants.first.id);
                            },
                            icon: Icon(
                              isWishlisted
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isWishlisted ? Colors.red : Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          try {
                            final variant = selectedVariant ?? product.variants.first;
                            final shareText = '''
Check out this amazing product on PickNow!

${product.name}
Price: ₹${variant.price}
${product.offer != 0 ? 'Offer: ${product.offer}% OFF' : ''}
${variant.size}

Download PickNow app to view more details and make a purchase!
''';
                            await Share.share(shareText);
                          } catch (e) {
                            // Show a snackbar or toast message if sharing fails
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Unable to share at this moment. Please try again later.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.share_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12),
                // Cart Button
                Expanded(
                  child: Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      final variant = selectedVariant ?? product.variants.first;
                      final bool inCart = cartProvider.cart?.items.any((item) =>
                              item.productId == widget.id &&
                              item.variantId == variant.id) ??
                          false;

                      return GestureDetector(
                        onTap: inCart
                            ? null
                            : () {
                                cartProvider.addToCart(
                                  widget.id,
                                  quantity,
                                  variant.type,
                                  variant.size,
                                  variant.price,
                                  variant.id,
                                );
                              },
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: inCart
                                ? Colors.grey.withOpacity(0.3)
                                : Colors.orange,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: inCart
                                ? []
                                : [
                                    BoxShadow(
                                      color: Colors.orange.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                inCart
                                    ? Icons.check
                                    : Icons.shopping_cart_outlined,
                                color: inCart ? Colors.grey : Colors.white,
                                size: 24,
                              ),
                              SizedBox(width: 8),
                              Text(
                                inCart ? 'Added to Cart' : 'Add to Cart',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: inCart ? Colors.grey : Colors.white,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmerLoading() {
    return Scaffold(
      appBar: customAppbar(context, ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmer for Image Carousel
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Shimmer for Product Name and Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 200,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 100,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Shimmer for Price and Offer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 120,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 80,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Shimmer for Variants
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 120,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: List.generate(
                  3,
                  (index) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 80,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Shimmer for Product Information
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 180,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Shimmer for Details Section
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildElegantShippingInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.grey.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFeatureCard(
            icon: Icons.local_shipping_outlined,
            title: 'Free Shipping',
            subtitle: 'On orders over ₹500',
            color: Colors.blue.shade700,
          ),
          const SizedBox(height: 14),
          _buildFeatureCard(
            icon: Icons.shield_outlined,
            title: 'Secure Payment',
            subtitle: '100% secure payment',
            color: Colors.green.shade700,
          ),
          // const SizedBox(height: 14),
          // _buildFeatureCard(
          //   icon: Icons.refresh,
          //   title: 'Easy Returns',
          //   subtitle: '7 day return policy',
          //   color: Colors.grey.shade700,
          // ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 24,
            color: color,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        )
      ],
    );
  }

  void _selectVariant(Variant variant) {
    setState(() {
      selectedVariant = variant;
      quantity = 1; // Reset quantity when variant changes
    });
  }
}
