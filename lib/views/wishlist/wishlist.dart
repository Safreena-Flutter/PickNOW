import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:picknow/costants/navigation/navigation.dart';
import 'package:picknow/costants/theme/appcolors.dart';
import 'package:picknow/views/products/detailed_page.dart';
import 'package:picknow/views/widgets/customappbar.dart';
import 'package:provider/provider.dart';
import '../../providers/cart/cart_provider.dart';
import '../../providers/whishlist/whishlist_provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WishlistProvider>(context, listen: false).loadWishlist();
    Provider.of<CartProvider>(context, listen: false).loadCart();
  }

  bool isProductInCart(CartProvider cartProvider, String productId, String variantId) {
    if (cartProvider.cart == null) return false;
    return cartProvider.cart!.items.any((item) => 
      item.productId == productId && item.variantId == variantId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, 'Wishlist',),
      
      body: Consumer2<WishlistProvider, CartProvider>(
        builder: (context, wishlistProvider, cartProvider, child) {
          if (wishlistProvider.isLoadingProducts) {
            return const Center(child: CircularProgressIndicator());
          }

          if (wishlistProvider.wishlist.isEmpty) {
            return  Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/animation/cart.json',
          width: 200,
          height: 200,
        ),
       
        const Text(
          'No items in wishlist',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: wishlistProvider.wishlist.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final product = wishlistProvider.wishlist[index];
                final bool inCart = isProductInCart(cartProvider, product.id, product.variant.id);

                return GestureDetector(
                  onTap: () => PageNavigations().push(PremiumProductDetailPage(id: product.id)),
                  child: Card(
                    color: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(8)),
                            child: Image.network(
                              product.image,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "₹${product.price}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete_outline_rounded,
                                  color: Colors.red),
                              onPressed: () {
                                Provider.of<WishlistProvider>(context,
                                        listen: false)
                                    .removeFromWishlist(product.id);
                              },
                            ),
                            ElevatedButton.icon(
                              onPressed: inCart ? null : () {
                                Provider.of<CartProvider>(context, listen: false)
                                    .addToCart(
                                  product.id,
                                  1,
                                  product.variant.type,
                                  product.variant.size,
                                  product.variant.price,
                                  product.variant.id
                                );
                              },
                              icon: Icon(
                                inCart ? Icons.check : Icons.shopping_bag,
                                color: Colors.white,
                                size: 18
                              ),
                              label: Text(
                                inCart ? "Added" : "Add",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: inCart ? Colors.grey : AppColors.orange,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
