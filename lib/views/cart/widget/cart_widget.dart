import 'package:flutter/material.dart';
import 'package:picknow/core/costants/navigation/navigation.dart';
import 'package:picknow/views/products/detailed_page.dart';

import '../../../core/costants/theme/appcolors.dart';
import '../../../providers/cart/cart_provider.dart';

Widget buildCartContent(CartProvider cartProvider, BuildContext context,
     double total) {
  return cartProvider.isLoading
      ? const Center(child: CircularProgressIndicator())
      : cartProvider.cart == null || cartProvider.cart!.items.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: cartProvider.cart!.items.length + 1, // +1 for summary card
              itemBuilder: (context, index) {
                if (index == cartProvider.cart!.items.length) {
                  // Summary card at the end
                  return SizedBox.shrink();
                }

                final item = cartProvider.cart!.items[index];
                return Dismissible(
                  key: ValueKey('${item.productId}-${item.variantId}'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.red[400],
                    child: const Icon(Icons.delete_outline,
                        color: Colors.white, size: 28),
                  ),
                  confirmDismiss: (direction) async {
                    if (item.productId == null || 
                        item.variantId == null || 
                        item.variantType == null || 
                        item.variantValue == null) {
                      return false;
                    }
                    
                    try {
                      await cartProvider.removeItem(
                        index,
                        item.productId!,
                        item.variantId!,
                        item.variantType!,
                        item.variantValue!
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('${item.name ?? 'Item'} removed from cart'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return true;
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Failed to remove item'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return false;
                    }
                  },
                  child: GestureDetector(
                    onTap: () => item.productId != null
                        ? PageNavigations()
                            .push(PremiumProductDetailPage(id: item.productId!))
                        : null,
                    child: Card(
                      color: AppColors.whiteColor,
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    item.images?.isNotEmpty == true
                                        ? item.images!.first
                                        : 'https://via.placeholder.com/90',
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) {
                                      return Container(
                                        width: 90,
                                        height: 90,
                                        color: Colors.grey[200],
                                        child: Icon(
                                            Icons.image_not_supported,
                                            color: Colors.grey[400]),
                                      );
                                    },
                                  ),
                                ),
                                if (item.offer > 0)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      '${item.offer.round()}% OFF',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name ?? "",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Price: ₹${item.price ?? 0}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Quantity: ${item.quantityInfo ?? ""}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        'Total: ₹${((item.price ?? 0) * item.quantity).toStringAsFixed(1)}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                      Icons.remove_circle_outline_rounded,
                                      color: AppColors.orange,
                                      size: 23),
                                  onPressed: () {
                                    if (item.quantity > 1 &&
                                        item.productId != null) {
                                      final newQuantity = item.quantity - 1;
                                      cartProvider.updateQuantity(
                                          index,
                                          newQuantity,
                                          item.variantType ?? '',
                                          item.variantValue ?? '',
                                          (item.price ?? 0) * newQuantity,
                                          item.variantId ?? '',
                                          item.productId!);
                                    }
                                  },
                                ),
                                Text(
                                  '${item.quantity}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                      Icons.add_circle_outline_rounded,
                                      color: Colors.orange,
                                      size: 23),
                                  onPressed: () {
                                    if (item.productId != null) {
                                      final newQuantity = item.quantity + 1;
                                      cartProvider.updateQuantity(
                                          index,
                                          newQuantity,
                                          item.variantType ?? '',
                                          item.variantValue ?? '',
                                          (item.price ?? 0) * newQuantity,
                                          item.variantId ?? '',
                                          item.productId!);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
}
