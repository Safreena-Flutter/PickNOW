import 'package:flutter/material.dart';
import 'package:picknow/views/cart/my_cart.dart';
import 'package:picknow/views/search/search_screen.dart';
import '../../core/costants/navigation/navigation.dart';
import '../wishlist/wishlist.dart';

AppBar customAppbar(BuildContext context, String? title) {
  return AppBar(
    automaticallyImplyLeading: false,
    leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios_new_rounded)),
    title: Text(title ?? ''),
    actions: [
      IconButton(
          onPressed: () {
            PageNavigations().push(SearchScreen());
          },
          icon: Icon(Icons.search)),
      IconButton(
          onPressed: () {
            PageNavigations().push(WishlistScreen());
          },
          icon: Icon(Icons.favorite_border)),
      IconButton(
          onPressed: () {
            PageNavigations().push(ShoppingCart(
              isfromhome: true,
            ));
          },
          icon: Icon(Icons.shopping_cart_outlined)),
    ],
  );
}
