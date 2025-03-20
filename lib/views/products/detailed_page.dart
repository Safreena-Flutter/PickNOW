// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:picknow/core/costants/navigation/navigation.dart';
import 'package:picknow/core/utils/convert_date.dart';
import 'package:picknow/views/wishlist/wishlist.dart';
import 'package:provider/provider.dart';
import '../../providers/cart/cart_provider.dart';
import '../../providers/combo/combo_provider.dart';
import '../../providers/product/product_detail_provider.dart';
import '../../core/costants/theme/appcolors.dart';
import '../../providers/product/related_products.dart';
import '../../providers/reviewproviders/review_provider.dart';
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
  int _currentImageIndex = 0;
  bool _isDetailsExpanded = false;
  bool _isFeaturesExpanded = false;
  bool _isReviewsExpanded = false;
  bool isFavorite = false;
  ComboListProvider comboListProvider = ComboListProvider();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductDetailProvider>().fetchProductDetails(widget.id);
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
          return Center(child: CircularProgressIndicator());
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
                  Stack(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 380,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                          //  autoPlay: true,
                          autoPlayInterval: Duration(seconds: 5),
                        ),
                        items: product.pImage.map((image) {
                          return Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  image: DecorationImage(
                                    image: NetworkImage(image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  product.pImage.asMap().entries.map((entry) {
                                return Container(
                                  width:
                                      _currentImageIndex == entry.key ? 24 : 8,
                                  height: 8,
                                  margin: EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: _currentImageIndex == entry.key
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.4),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                            product.pName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
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
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                PageNavigations().push(WishlistScreen());
                              },
                              icon: Icon(
                                Icons.favorite_border,
                                color: AppColors.grey,
                              )),
                          IconButton(
                              onPressed: () {
                                //   PageNavigations().push(WishlistScreen());
                              },
                              icon: Icon(
                                Icons.share,
                                color: AppColors.grey,
                              )),
                        ],
                      )
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
                            '₹${product.pPrice.toString()}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '₹${product.pPreviousPrice.toString()}',
                            style: TextStyle(
                              fontSize: 17,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      product.pOffer != '0'
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                '${product.pOffer}% OFF',
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
                            DetailRow(label: 'Brand', value: product.pBrand),
                            DetailRow(
                                label: 'Net Quantity',
                                value: product.pQuantity),
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
                              product.pShortDescription,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: Colors.grey[800],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              product.pDescription,
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

                      return FeaturedProductsList(
                        from: true,
                        products: relatedprovider.relatedProducts
                            .map((product) => {
                                  'id': product.id,
                                  'offer': product.offer,
                                  'name': product.name,
                                  'weight': product.quantity,
                                  'price': product.price,
                                  'originalPrice': product.previousPrice,
                                  'imageUrl': product.images.first,
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
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        Provider.of<CartProvider>(context, listen: false)
                            .addToCart(
                      widget.id,
                      1,
                    ),
                    child: Container(
                      height: 56,
                      margin: EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined),
                          SizedBox(width: 8),
                          Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.flash_on, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Buy Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
          const SizedBox(height: 14),
          _buildFeatureCard(
            icon: Icons.refresh,
            title: 'Easy Returns',
            subtitle: '7 day return policy',
            color: Colors.grey.shade700,
          ),
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
}
