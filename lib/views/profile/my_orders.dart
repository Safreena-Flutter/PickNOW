import 'package:flutter/material.dart';
import 'package:picknow/costants/theme/appcolors.dart';
import 'package:picknow/views/profile/orders/all_orders.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5, 
        child: Scaffold(
          appBar: AppBar(
            title: Text("My Orders"),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.whiteColor)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TabBar(
                            indicator: BoxDecoration(
                              color: AppColors.orange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            dividerColor: AppColors.whiteColor,
                            indicatorSize: TabBarIndicatorSize.tab,
                            isScrollable: true,
                            labelStyle: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                            indicatorColor:
                                AppColors.orange, // Customize as needed
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              Tab(text: "All"),
                              Tab(text: "On the way"),
                              Tab(text: "Delivered"),
                              Tab(text: "Cancelled"),
                              Tab(text: "Returned"),
                            ],
                          ),
                        )))),
           
          ),
           body: TabBarView(
              children: [
              AllOrders(products: [
            {
              "image" : "https://images.meesho.com/images/products/375414458/qcccm_512.webp",
              "name" : "Bajra biscuit/கம்பு பிஸ்கட்",
              "delivery" : "Delivery Expected by Feb 24",
              "isdelivered" : false
            },
             {
              "image" : "https://cdn.shopify.com/s/files/1/0655/6414/7950/files/10-must-try-refreshing-summer-drinks-2.jpg?v=1713871057",
              "name" : "Millet/சிறுதானியம்",
              "delivery" : "Refund completed",
              "isdelivered" : false
            },
              {
              "image" : "https://m.media-amazon.com/images/I/71g7abt4RAL.jpg",
              "name" : "Bajra biscuit/கம்பு பிஸ்கட்",
              "delivery" : "Delivered on Jan 10",
              "isdelivered" : true
            },
              {
              "image" : "https://i2.wp.com/www.holar.com.tw/wp-content/uploads/Holar-Blog-What-are-the-uses-for-different-edible-oils-when-cooking-Sunflower-Oil.jpg?resize=600%2C337&ssl=1",
              "name" : "Sunflower Oil/சூரியகாந்தி எண்ணெய்",
              "delivery" : "Cancelled on Nov 13, 2024",
              "isdelivered" : false
            },
              ],),
                Center(child: Text("Pending Orders")),
                Center(child: Text("Shipped Orders")),
                Center(child: Text("Delivered Orders")),
                Center(child: Text("Returned Orders")),
              ],
            ),
        )
        );
  }
}
