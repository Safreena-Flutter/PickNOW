// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:picknow/providers/whishlist/whishlist_provider.dart';
import 'package:picknow/views/cart/address.dart';
import 'package:picknow/views/category/widget/category_iconwidget.dart';
import 'package:provider/provider.dart';
import '../../costants/navigation/navigation.dart';
import '../../model/address/address.dart';
import '../../providers/cart/cart_provider.dart';
import '../search/search_screen.dart';
import '../wishlist/wishlist.dart';
import 'package:picknow/costants/theme/appcolors.dart';
import 'package:picknow/views/cart/payment_option.dart';
import 'package:picknow/views/cart/step.dart';
import '../../costants/mediaquery/mediaquery.dart';
import '../widgets/customtext.dart';
import 'widget/cart_widget.dart';

class ShoppingCart extends StatefulWidget {
  final bool isfromhome;
  const ShoppingCart({super.key, required this.isfromhome});

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  int currentstep = 0;
  Address? selectedAddress;

  void moveToNextStep() {
    setState(() {
      if (currentstep < 2) {
        currentstep += 1;
      }
    });
  }

  Widget _buildStepContent(
      CartProvider cartprovider, BuildContext contex, double total) {
    switch (currentstep) {
      case 0:
        return buildCartContent(cartprovider, contex, total);
      case 1:
        return AddressScreen(
          false,
          onAddressSelected: (Address address) {
            setState(() {
              selectedAddress = address;
              currentstep = 2;
            });
          },
        );
      case 2:
        return PaymentScreen(
          selectedAddress: selectedAddress!,
          total: total.round(),
        );
      default:
        return buildCartContent(cartprovider, contex, total);
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).loadCart();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    double total = cartProvider.cart?.finalAmount ?? 0;
    return Scaffold(
      appBar: AppBar(
        leading: widget.isfromhome == true
            ? IconButton(
                onPressed: () {
                  PageNavigations().pop();
                },
                icon: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.lightgrey),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20,
                    )))
            : SizedBox.shrink(),
        title: CustomText(
            text: "My Cart", size: 0.04, color: AppColors.blackColor),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    PageNavigations().push(SearchScreen());
                  },
                  icon: Icon(Icons.search)),
              Consumer<WishlistProvider>(
                builder: (_, wishlist, __) =>
                    buildAnimatedIconButton(
                      Icons.favorite_border,
                      badge: wishlist.wishlist.length.toString(),
                      onPressed: () {
                        PageNavigations()
                            .push(WishlistScreen());
                      },
                    ),
              ),
            ],
          )
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(
            color: AppColors.frost,
            height: mediaqueryheight(0.1, context),
            child: Stepper(
              type: StepperType.horizontal,
              steps: getsteps(currentstep),
              currentStep: currentstep,
              onStepTapped: (value) {
                setState(() {
                  currentstep = value;
                });
              },
              elevation: 0,
              physics: BouncingScrollPhysics(),
            ),
          ),
          Expanded(
            child: _buildStepContent(cartProvider, context, total),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 6,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Total Amount',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '₹${total.round()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if (cartProvider.cart?.items.isNotEmpty == true) {
                      if (currentstep == 0) {
                        moveToNextStep();
                      } else if (currentstep == 1 && selectedAddress != null) {
                        moveToNextStep();
                      } else if (currentstep == 2) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Order placed successfully!'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else if (currentstep == 1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select an address'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Your cart is empty!'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: cartProvider.cart?.items.isEmpty == true ? Colors.grey : AppColors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: mediaqueryheight(0.06, context),
                    width: mediaquerywidth(0.4, context),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.keyboard_double_arrow_right_outlined,
                            color: AppColors.whiteColor,
                          ),
                          CustomText(
                            text: currentstep == 0
                                ? "CHECKOUT"
                                : currentstep == 1
                                    ? "PROCEED TO PAY"
                                    : "PLACE ORDER",
                            size: 0.035,
                            color: AppColors.whiteColor,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
