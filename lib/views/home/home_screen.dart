// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:picknow/providers/product/offer_provider.dart';
import 'package:picknow/providers/product/latest_product_provider.dart';
import 'package:picknow/views/home/widgets/carosel.dart';
import 'package:picknow/views/home/widgets/productlist.dart';
import 'package:picknow/views/home/widgets/title.dart';
import 'package:picknow/views/home/widgets/vendors_list.dart';
import 'package:picknow/views/widgets/customsizedbox.dart';
import 'package:provider/provider.dart';
//import 'package:video_player/video_player.dart';
import 'package:shimmer/shimmer.dart';
import '../../providers/category/all_category.dart';
import '../../providers/combo/combo_provider.dart';
import 'widgets/category_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//  late VideoPlayerController _videoController;
  final ScrollController _scrollController = ScrollController();
  ComboListProvider comboListProvider = ComboListProvider();
  // bool _isVideoVisible = true;
  // final GlobalKey _videoKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
      Provider.of<OfferProvider>(context, listen: false).fetchOfferProducts();
      Provider.of<LatestProductProvider>(context, listen: false)
          .fetchLatestProducts();
      context.read<ComboListProvider>().comboProducts(refresh: true);
      comboListProvider.comboProducts();
    });

    // _videoController = VideoPlayerController.asset('assets/video/video.mp4')
    //   ..initialize().then((_) {
    //     setState(() {}); // Refresh the screen after initialization
    //     _videoController.play(); // Start playing automatically
    //   });
    // _videoController.setLooping(true);

    // _scrollController.addListener(_onScroll);
  }

  // void _onScroll() {
  //   // Get the position of the video widget
  //   final videoPosition =
  //       _videoKey.currentContext?.findRenderObject() as RenderBox?;
  //   const visibilityThreshold =
  //       50.0; // Pixels the widget must be within to consider visible

  //   if (videoPosition != null) {
  //     final videoRect =
  //         videoPosition.localToGlobal(Offset.zero) & videoPosition.size;
  //     final screenSize = MediaQuery.of(context).size;

  //     final isVisible = videoRect.top + visibilityThreshold >= 0 &&
  //         videoRect.bottom - visibilityThreshold <= screenSize.height;

  //     if (_isVideoVisible != isVisible) {
  //       setState(() {
  //         _isVideoVisible = isVisible;
  //         if (_isVideoVisible) {
  //           _videoController.play();
  //         } else {
  //           _videoController.pause();
  //         }
  //       });
  //     }
  //   }
  // }

  @override
  void dispose() {
    _scrollController.dispose();
    //   _videoController.dispose();
    super.dispose();
  }

  Widget _buildShimmerSection() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shimmer for section title
          Container(
            width: 150,
            height: 24,
            margin: const EdgeInsets.only(left: 16, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          // Shimmer for product list
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.34,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Shimmer for product image
                      Container(
                        height: MediaQuery.of(context).size.width * 0.45,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: buildCategoriesRow(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ImageCarousel(),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: buildSectionTitle('Combo Offers'),
                  ),
                  Consumer<ComboListProvider>(
                    builder: (context, comboProvider, child) {
                      if (comboProvider.isLoading &&
                          comboProvider.products.isEmpty) {
                        return _buildShimmerSection();
                      }

                      if (comboProvider.error != null) {
                        return Center(
                            child: Text('Error: ${comboProvider.error}'));
                      }

                      return FeaturedProductsList(
                        from: true,
                        products: comboProvider.products
                            .map((combo) => {
                                  'id': combo.id,
                                  'offer': combo.ccOffer,
                                  'name': combo.ccName,
                                  'weight': combo.ccQuantity.toString(),
                                  'price': combo.ccPrice,
                                  'originalPrice': combo.ccPrice,
                                  'imageUrl': combo.ccImage,
                                  "varientid": combo.id
                                })
                            .toList(),
                      );
                    },
                  ),
                  CustomSizedBoxHeight(0.02),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: buildSectionTitle('Special Offers'),
                  ),
                  Consumer<OfferProvider>(
                    builder: (context, offerProvider, child) {
                      if (offerProvider.isLoading &&
                          offerProvider.products.isEmpty) {
                        return _buildShimmerSection();
                      }

                      if (offerProvider.error != null) {
                        return Center(
                            child: Text('Error: ${offerProvider.error}'));
                      }

                      return FeaturedProductsList(
                        from: false,
                        products: offerProvider.products
                            .map((product) => {
                                  'id': product.productId,
                                  'offer': product.offer,
                                  'name': product.pName,
                                  'weight': product.size,
                                  'price': product.price,
                                  'originalPrice': product.previousPrice,
                                  'imageUrl': product.pImage.first,
                                  "varientid": product.variantId
                                })
                            .toList(),
                      );
                    },
                  ),
                  CustomSizedBoxHeight(0.02),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: SingleChildScrollView(
                  //       controller: _scrollController,
                  //       child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             ClipRRect(
                  //               borderRadius: BorderRadius.circular(12),
                  //               child: SizedBox(
                  //                 key: _videoKey,
                  //                 width: double.infinity,
                  //                 child: _videoController.value.isInitialized
                  //                     ? AspectRatio(
                  //                         aspectRatio: _videoController
                  //                             .value.aspectRatio,
                  //                         child: VideoPlayer(_videoController),
                  //                       )
                  //                     : const Center(
                  //                         child: CircularProgressIndicator(),
                  //                       ),
                  //               ),
                  //             ),
                  //           ])),
                  // ),
                  CustomSizedBoxHeight(0.02),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: buildSectionTitle('Latest Products'),
                  ),
                  Consumer<LatestProductProvider>(
                    builder: (context, latestProvider, child) {
                      if (latestProvider.isLoading &&
                          latestProvider.products.isEmpty) {
                        return _buildShimmerSection();
                      }

                      if (latestProvider.error != null) {
                        return Center(
                            child: Text('Error: ${latestProvider.error}'));
                      }

                      return FeaturedProductsList(
                        from: false,
                        products: latestProvider.products
                            .where((product) => product.variantDetails != null)
                            .map((product) => {
                                  'id': product.id,
                                  'offer': product.variantDetails!.offer,
                                  'name': product.pName,
                                  'weight': product.variantDetails!.size,
                                  'price': product.variantDetails!.price,
                                  'originalPrice':
                                      product.variantDetails!.previousPrice,
                                  'imageUrl': product.pImage.first,
                                  "varientid": product.variantDetails!.id
                                })
                            .toList(),
                      );
                    },
                  ),
                  CustomSizedBoxHeight(0.02),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: buildSectionTitle('Our Sellers'),
                  ),
                  VendorsList(products: [
                    {
                      'name': 'IHA',
                      'imageUrl':
                          'https://assets.zenn.com/strapi_assets/Organic_food_logo_1699547c2d.png',
                    },
                    {
                      'name': 'Dhaanyas',
                      'imageUrl':
                          'https://marketplace.canva.com/EAFzZi-J0-E/1/0/1600w/canva-green-vintage-agriculture-and-farming-logo--T6aMcjxDtw.jpg',
                    },
                    {
                      'name': "Millets 'n' minutes",
                      'imageUrl':
                          'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/organic-food-logo-design-template-a6555fa7f226417cf106138a0ce83c2b_screen.jpg?ts=1676219912',
                    },
                    {
                      'name': "N BITEZ",
                      'imageUrl':
                          'https://t3.ftcdn.net/jpg/05/76/56/86/360_F_576568694_q7D3VHOFv9p9BB3ahbBXUNodr4oxPsGh.jpg',
                    },
                    {
                      'name': "Dhana food products",
                      'imageUrl':
                          'https://images.vexels.com/media/users/3/174183/raw/341bac228d173b78d5a523c6d1e1c597-organic-market-logo-template.jpg',
                    },
                  ]),
                  CustomSizedBoxHeight(0.02),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
