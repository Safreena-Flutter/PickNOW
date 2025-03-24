import 'package:flutter/material.dart';
import 'package:picknow/core/costants/navigation/navigation.dart';
import 'package:picknow/core/costants/theme/appcolors.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, 'Whishlist',),
      
      body: Consumer<WishlistProvider>(
        builder: (context, wishlistProvider, child) {
          if (wishlistProvider.isLoadingProducts) {
            return const Center(child: CircularProgressIndicator());
          }

          if (wishlistProvider.wishlist.isEmpty) {
            return const Center(child: Text("No items in wishlist"));
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
                              
                              onPressed: () {
                                Provider.of<CartProvider>(context, listen: false)
                                    .addToCart(
                                  product.id,
                                  1,
                                );
                              },
                              icon: const Icon(Icons.shopping_bag,
                                  color: Colors.white, size: 18),
                              label: Text("Add",
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                            
                                backgroundColor: AppColors.orange,
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
