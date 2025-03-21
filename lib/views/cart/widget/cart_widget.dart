 import 'package:flutter/material.dart';

import '../../../core/costants/theme/appcolors.dart';
import '../../../providers/cart/cart_provider.dart';

Widget buildCartContent(CartProvider cartProvider,BuildContext context, double subtotal,
      double tax,
      double delivery,
      double total) {

    return cartProvider.isLoading
        ? Center(child: CircularProgressIndicator())
        : cartProvider.cart == null || cartProvider.cart!.items.isEmpty
            ? Center(child: Text('Your cart is empty'))
            : ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  ...List.generate(
                    cartProvider.cart!.items.length,
                    (index) {
                      final item = cartProvider.cart!.items[index];
                      return Dismissible(
                        key: Key(item.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          color: Colors.red[400],
                          child: Icon(Icons.delete_outline,
                              color: Colors.white, size: 28),
                        ),
                        onDismissed: (direction) {
                          cartProvider.removeItem(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('${item.name} removed from cart'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
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
                                        item.images.first,
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    if (item.discountPercentage > 0)
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
                                          '${item.discountPercentage.round()}% OFF',
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
                                        item.name,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        item.weight,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(
                                            '₹${(item.price * item.quantity) }',
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
                                        if (item.quantity > 1) {
                                          cartProvider.updateQuantity(
                                              index, item.quantity - 1);
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
                                        cartProvider.updateQuantity(
                                            index, item.quantity + 1);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Card(
                    margin: EdgeInsets.all(15),
                    elevation: 0.5,
                    color: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Subtotal',
                                  style: TextStyle(color: Colors.grey[600])),
                              Text('₹${subtotal.toStringAsFixed(2)}'),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tax (4%)',
                                  style: TextStyle(color: Colors.grey[600])),
                              Text('₹${tax.toStringAsFixed(2)}'),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery Charge',
                                  style: TextStyle(color: Colors.grey[600])),
                              Text(
                                delivery == 0
                                    ? 'FREE'
                                    : '₹${delivery.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: delivery == 0
                                        ? Colors.green
                                        : Colors.black),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Amount',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                '₹${total.round()}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
  }
