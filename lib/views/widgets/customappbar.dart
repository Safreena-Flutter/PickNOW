import 'package:flutter/material.dart';
import 'package:picknow/providers/cart/cart_provider.dart';
import 'package:picknow/views/cart/my_cart.dart';
import 'package:picknow/views/category/widget/category_iconwidget.dart';
import 'package:picknow/views/search/search_screen.dart';
import 'package:provider/provider.dart';
import '../../core/costants/navigation/navigation.dart';

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
      Consumer<CartProvider>(
            builder: (_, cart, __) => buildAnimatedIconButton(
              Icons.shopping_cart_outlined,
              badge: cart.itemCount.toString(),
              onPressed: () {
                PageNavigations().push(ShoppingCart(isfromhome: true));
              },
            ),
          ),
    ],
  );
}
