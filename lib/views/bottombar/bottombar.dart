// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:picknow/core/costants/mediaquery/mediaquery.dart';
import 'package:picknow/core/costants/navigation/navigation.dart';
import 'package:picknow/views/address/current_address.dart';
import 'package:picknow/views/wishlist/wishlist.dart';
import 'package:provider/provider.dart';
import '../../core/costants/theme/appcolors.dart';
import '../../providers/cart/cart_provider.dart';
import '../cart/my_cart.dart';
import '../category/categories_view.dart';
import '../category/widget/category_iconwidget.dart';
import '../profile/profile.dart';
import '../search/search_screen.dart';
import '../widgets/customtext.dart';
import '../home/home_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  PageController pageController = PageController();
  String _currentAddress = "Fetch address";
  bool _isLoading = false;
  final LocationService _locationService = LocationService();
  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    setState(() {
      _isLoading = true;
    });

    String address = await _locationService.getCurrentLocation();

    setState(() {
      _currentAddress = address;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeScreen(),
      CategoryPage(
        isfromhome: false,
      ),
      ShoppingCart(
        isfromhome: false,
      ),
      ProfileScreen(
        address: _currentAddress,
      ),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: currentIndex == 0
            ? Size.fromHeight(mediaqueryheight(0.18, context))
            : const Size.fromHeight(90.0),
        child: SafeArea(
            child: currentIndex == 0
                ? Container(
                    decoration: BoxDecoration(color: AppColors.frost),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          WillPopScope(
                            onWillPop: () async {
                              _isLoading ? null : _fetchLocation();
                              return true;
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 30,
                                      color: AppColors.grey,
                                    ),
                                    _isLoading
                                        ? CircularProgressIndicator()
                                        : SizedBox(
                                            width:
                                                mediaquerywidth(0.4, context),
                                            child: CustomText(
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                              text: _currentAddress,
                                              size: 0.035,
                                              color: Colors.black,
                                              weight: FontWeight.w700,
                                            ),
                                          ),
                                    Icon(Icons.arrow_drop_down_sharp)
                                  ],
                                ),
                                // Action Buttons
                                Row(
                                  children: [
                                    Consumer<CartProvider>(
                                      builder: (_, cart, __) =>
                                          buildAnimatedIconButton(
                                        Icons.shopping_cart_outlined,
                                        badge: cart.itemCount.toString(),
                                        onPressed: () {
                                          PageNavigations().push(
                                              ShoppingCart(isfromhome: true));
                                        },
                                      ),
                                    ),
                                    buildAnimatedIconButton(
                                      Icons.favorite_border,
                                     // badge: '3',
                                      onPressed: () {
                                        PageNavigations().push(WishlistPage());
                                      },
                                    ),
                                    buildAnimatedIconButton(
                                      Icons.notifications_none_outlined,
                                      onPressed: () {},
                                     // badge: '3',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SearchBar(
                            onTap: () {
                              PageNavigations().push(SearchScreen());
                            },
                            constraints: BoxConstraints(
                                maxHeight: mediaqueryheight(0.065, context),
                                maxWidth: mediaquerywidth(0.9, context)),
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    side: BorderSide(
                                        color:
                                            AppColors.orange.withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(12))),
                            hintText: 'Search products...',
                            hintStyle: WidgetStatePropertyAll(
                              TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            elevation: WidgetStateProperty.all(0),
                            leading: Image.asset(
                              "assets/images/logo.png",
                              height: 45,
                              width: 45,
                              fit: BoxFit.cover,
                            ),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white),
                            padding: const WidgetStatePropertyAll<EdgeInsets>(
                              EdgeInsets.only(left: 8, right: 8),
                            ),
                            trailing: [Icon(Icons.filter_list_rounded)],
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink()),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  FocusScope.of(context).unfocus();
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return pages[index];
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.grey,
            activeColor: AppColors.orange,
            tabBackgroundColor: AppColors.cream.withOpacity(0.4),
            gap: 6,
            padding: const EdgeInsets.all(14),
            tabs: const [
              GButton(text: 'Home', icon: Icons.home),
              GButton(text: 'Categories', icon: Icons.grid_view_rounded),
              GButton(text: 'My Cart', icon: Icons.shopping_cart_outlined),
              GButton(text: 'Profile', icon: Icons.account_circle),
            ],
            onTabChange: (index) {
              pageController.jumpToPage(index);
            },
          ),
        ),
      ),
    );
  }
}
