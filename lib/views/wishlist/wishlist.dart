// ignore_for_file: library_private_types_in_public_api, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:picknow/views/widgets/customtext.dart';
import 'package:provider/provider.dart';

import '../../core/costants/navigation/navigation.dart';
import '../../core/costants/theme/appcolors.dart';
import '../../providers/cart/cart_provider.dart';
import '../cart/my_cart.dart';
import '../category/widget/category_iconwidget.dart';
import '../search/search_screen.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final List<Map<String, dynamic>> wishlistItems = [
    {
      'name': 'Dry Kiwi/உலர் கிவி',
      'image':
          'https://images.meesho.com/images/products/375414458/qcccm_512.webp',
      'price': 80.00,
      'unit': '100 g',
      'offer': 0.5,
      "discount": 100.99
    },
    {
      'name': 'Handmade Soaps/சோப்பு',
      'image':
          'https://cdn.shopify.com/s/files/1/0490/1158/9282/files/sundarisilks-natural-handmade-soaps.png?v=1629446125',
      'price': 180.00,
      'unit': '3 Pc',
      'offer': 0.2,
      "discount": 180.00
    },
    {
      'name': 'Millet/சிறுதானியம்',
      'image':
          'https://cdn.shopify.com/s/files/1/0655/6414/7950/files/10-must-try-refreshing-summer-drinks-2.jpg?v=1713871057',
      'price': 160.05,
      'unit': '280 g',
      'offer': 0.1,
      "discount": 200.00
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              PageNavigations().pop();
            },
            icon: Container(
                decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.2),
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(Icons.arrow_back_ios_new_rounded),
                ))),
        title: CustomText(
          text: "Whishlist",
          size: 0.04,
          color: AppColors.blackColor,
          weight: FontWeight.bold,
        ),
        actions: [
          Row(
            children: [
               IconButton(
                  onPressed: () {
                     PageNavigations().push(SearchScreen());
                  }, icon: Icon(Icons.search)),
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
            ],
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(top: 10),
                itemCount: wishlistItems.length,
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemBuilder: (context, index) {
                  var item = wishlistItems[index];
                  return _buildWishlistItem(item, index);
                },
              ),
            ),
            _buildAddToCartButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistItem(Map<String, dynamic> item, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: _buildProductImage(item['image']),
        title: Text(
          item['name'],
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black87,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: _buildItemDetails(item),
        trailing: _buildPriceAndDeleteAction(item, index),
      ),
    );
  }

  Widget _buildProductImage(String imageUrl) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildItemDetails(Map<String, dynamic> item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${item['unit']}',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${(item['offer'] * 100).toInt()}% OFF',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndDeleteAction(Map<String, dynamic> item, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '₹${item['price'].toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Text(
              "₹${item['discount'].toStringAsFixed(2)}",
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.red, size: 24),
          onPressed: () {
            setState(() {
              wishlistItems.removeAt(index);
            });
          },
        ),
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green, Colors.green.shade700],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            // Add to cart logic
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: Text(
                'Add All to Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
