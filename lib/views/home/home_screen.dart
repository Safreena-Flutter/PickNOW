// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:picknow/views/home/widgets/carosel.dart';
import 'package:picknow/views/home/widgets/productlist.dart';
import 'package:picknow/views/home/widgets/title.dart';
import 'package:picknow/views/home/widgets/vendors_list.dart';
import 'package:picknow/views/widgets/customsizedbox.dart';
import 'package:provider/provider.dart';
//import 'package:video_player/video_player.dart';
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
                        return const Center(child: CircularProgressIndicator());
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
                                  'weight': combo.ccQuantity
                                      .toString(), // Example weight
                                  'price': combo.ccPrice,
                                  'originalPrice': combo.ccPrice,
                                  'imageUrl': combo.ccImage,
                                })
                            .toList(),
                      );
                    },
                  ),
                  CustomSizedBoxHeight(0.02),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: buildSectionTitle('Best Selling'),
                  ),
                  FeaturedProductsList(
                    products: [
                      {
                        'id': "haksfka",
                        'offer': 10,
                        'name': 'Almond/பாதாம்',
                        'weight': '200 g',
                        'price': 60,
                        'originalPrice': 100,
                        'imageUrl':
                            'https://cdn.britannica.com/04/194904-050-1B92812A/Raw-Food-Almond-food-Nut-Snack.jpg',
                      },
                      {
                        'id': "haksfka",
                        'offer': 5,
                        'name': 'Dry Kiwi/உலர் கிவி',
                        'weight': '200 g',
                        'price': 80,
                        'originalPrice': 100,
                        'imageUrl':
                            'https://images.meesho.com/images/products/375414458/qcccm_512.webp',
                      },
                      {
                        'id': "haksfka",
                        'offer': 10,
                        'name': "Bajra biscuit/கம்பு பிஸ்கட்",
                        'weight': '100 g',
                        'price': 60,
                        'originalPrice': 90,
                        'imageUrl':
                            'https://m.media-amazon.com/images/I/71g7abt4RAL.jpg',
                      },
                    ],
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
                  FeaturedProductsList(
                    products: [
                      {
                        'id': "haksfka",
                        'offer': 10,
                        'name': 'ABC malt/ஏபிசி மால்ட்',
                        'weight': '500 g',
                        'price': 150,
                        'originalPrice': 200,
                        'imageUrl':
                            'https://dakshindelight.com/cdn/shop/files/DSC_1605.jpg?v=1713884178&width=1946',
                      },
                      {
                        'id': "haksfka",
                        'offer': 10,
                        'name': 'Handmade Soaps/சோப்பு',
                        'weight': '200 g',
                        'price': 60,
                        'originalPrice': 80,
                        'imageUrl':
                            'https://cdn.shopify.com/s/files/1/0490/1158/9282/files/sundarisilks-natural-handmade-soaps.png?v=1629446125',
                      },
                      {
                        'id': "haksfka",
                        'offer': 10,
                        'name': "Cardamom/ஏலக்காய்",
                        'weight': '100 g',
                        'price': 60,
                        'originalPrice': 90,
                        'imageUrl':
                            'https://www.greendna.in/cdn/shop/products/Cardamom_640x.png?v=1560959843',
                      },
                    ],
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

