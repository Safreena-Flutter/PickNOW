// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:picknow/views/cart/address.dart';
import 'package:provider/provider.dart';
import '../../core/costants/navigation/navigation.dart';
import '../../providers/cart/cart_provider.dart';
import '../search/search_screen.dart';
import '../wishlist/wishlist.dart';
import 'package:picknow/core/costants/theme/appcolors.dart';
import 'package:picknow/views/cart/payment_option.dart';
import 'package:picknow/views/cart/step.dart';
import '../../core/costants/mediaquery/mediaquery.dart';
import '../address/current_address.dart';
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

  String _currentAddress = "Fetch address";
  final LocationService _locationService = LocationService();

  void moveToNextStep() {
    setState(() {
      if (currentstep < 2) {
        currentstep += 1;
      }
    });
  }

  Widget _buildStepContent(
      String currentaddress,
      CartProvider cartprovider,
      BuildContext contex,
      double subtotal,
      double tax,
      double delivery,
      double total) {
    switch (currentstep) {
      case 0:
        return buildCartContent(
            cartprovider, contex, subtotal, tax, delivery, total);
      case 1:
        return AddressScreen(currentaddress, false);
      case 2:
        return buildPaymentOptions(total);
      default:
        return buildCartContent(
            cartprovider, contex, subtotal, tax, delivery, total);
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).loadCart();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    setState(() {});

    String address = await _locationService.getCurrentLocation();

    setState(() {
      _currentAddress = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    double subtotal = cartProvider.cart?.items
            .fold(0, (sum, item) => sum! + (item.price * item.quantity)) ??
        0;
    double tax = subtotal * 0.04;
    double deliveryCharge = subtotal > 500 ? 0 : 50;
    double total = subtotal + tax + deliveryCharge;
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
              IconButton(
                  onPressed: () {
                    PageNavigations().push(WishlistScreen());
                  },
                  icon: Icon(Icons.favorite_border))
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
            child: _buildStepContent(_currentAddress, cartProvider, context,
                subtotal, tax, deliveryCharge, total),
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
                    if (subtotal != 0) {
                      if (currentstep < 2) {
                        moveToNextStep();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Order placed successfully!'),
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
                      color: subtotal == 0 ? Colors.grey : AppColors.orange,
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
