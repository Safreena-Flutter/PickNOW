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
import '../../providers/brand/brand_provider.dart';
import '../../providers/category/all_category.dart';
import '../../providers/combo/combo_provider.dart';
import 'widgets/category_widget.dart';
import 'widgets/shimmer_widget.dart';

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
      Provider.of<BrandProvider>(context, listen: false).fetchBrands();
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
                        return buildShimmerSection(context);
                      }

                      if (comboProvider.error != null) {
                        return Center(
                            child: Text('Error: ${comboProvider.error}'));
                      }

                      if (comboProvider.products.isEmpty) {
                        return const Center(
                            child: Text('No combo products available'));
                      }

                      return FeaturedProductsList(
                        from: true,
                        products: comboProvider.products.map((combo) {
                          // Safely extract variant and weight
                          final variant = (combo.variants.isNotEmpty)
                              ? combo.variants.first
                              : null;
                          final weight = variant?.size ?? variant?.size ?? '';

                          return {
                            'id': combo.id,
                            'offer': int.tryParse(combo.pOffer.toString()) ?? 0,
                            'name': combo.pName,
                            'weight': weight,
                            'price': variant?.price ?? 0,
                            'originalPrice': variant?.previousPrice ?? 0,
                            'imageUrl': (combo.pImage.isNotEmpty)
                                ? combo.pImage.first
                                : (combo.pImage),
                            'varientid': variant?.id ?? '',
                                 'brand' : combo.pBrand 
                          };
                        }).toList(),
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
                        return buildShimmerSection(context);
                      }

                      if (offerProvider.error != null) {
                        return Center(
                            child: Text('Error: ${offerProvider.error}'));
                      }

                      return FeaturedProductsList(
                        from: true,
                        products: offerProvider.products
                            .map((product) => {
                                  'id': product.productId,
                                  'offer': product.offer,
                                  'name': product.pName,
                                  'weight': product.size,
                                  'price': product.price,
                                  'originalPrice': product.previousPrice,
                                  'imageUrl': product.pImage.first,
                                  "varientid": product.variantId,
                                       'brand' : product.pBrand 
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
                    child: buildSectionTitle('Top Brands'),
                  ),
                  Consumer<BrandProvider>(
                    builder: (context, brandProvider, child) {
                      if (brandProvider.isLoading) {
                        return buildShimmerSection(context);
                      }
                      if (brandProvider.error != null) {
                        return Center(
                            child: Text('Error: ${brandProvider.error}'));
                      }

                      final products = brandProvider.brands
                          .map((brand) => {
                                'name': brand.name,
                                'imageUrl': brand.logo,
                                'id' : brand.id
                              })
                          .toList();

                      return VendorsList(products: products);
                    },
                  ),
                  CustomSizedBoxHeight(0.02),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: buildSectionTitle('Latest Products'),
                  ),
                  Consumer<LatestProductProvider>(
                    builder: (context, latestProvider, child) {
                      if (latestProvider.isLoading &&
                          latestProvider.products.isEmpty) {
                        return buildShimmerSection(context);
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
                                  'offer': product.variantDetails?.offer ??0,
                                  'name': product.pName,
                                  'weight': product.variantDetails!.size,
                                  'price': product.variantDetails!.price,
                                  'originalPrice':
                                      product.variantDetails?.previousPrice ?? 0,
                                  'imageUrl': product.pImage.first,
                                  "varientid": product.variantDetails?.id ?? '',
                                  'brand' : product.pBrand 
                                })
                            .toList(),
                      );
                    },
                  ),
                  CustomSizedBoxHeight(0.02),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: buildSectionTitle('Why PickNow Products ?'),
                  ),
                  InfoList(products: [
                    {
                      'name': "100% Natural & Organic",
                      'imageUrl': '4',
                    },
                    {
                      'name': 'Flavorful & Nourishing',
                      'imageUrl': '1',
                    },
                    {
                      'name': 'Health and Wellness Focus',
                      'imageUrl': '2',
                    },
                    {
                      'name': "Trusted & Loved",
                      'imageUrl': '3',
                    },
                  ]),
                  CustomSizedBoxHeight(0.01),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
