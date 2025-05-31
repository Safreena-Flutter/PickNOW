import 'package:flutter/material.dart';
import 'package:picknow/costants/theme/appcolors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
        backgroundColor: AppColors.orange
      ),
      body: SingleChildScrollView( // Make content scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Welcome to PickNow!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),

            Text(
              'PickNow is your trusted e-commerce platform, focused on offering organic, healthier, and high-quality products. Every item we sell is carefully verified to ensure authenticity, purity, and customer satisfaction.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 12),

            Text(
              'Our marketplace features products with rich taste and nutritional value, promoting a sustainable and conscious lifestyle for our customers.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 15),

            Text(
              'What You Can Do on PickNow:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '🛒 Add to Cart:\nEasily browse and add your favorite products to your shopping cart for a seamless checkout experience.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 8),

            Text(
              '❤️ Add to Wishlist:\nNot ready to buy? Save products you love to your wishlist and revisit them anytime.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 8),

            Text(
              '💳 Quick Checkout:\nEnjoy a secure and fast checkout payment options.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 8),

            Text(
              '📦 Track Orders:\nGet updates and track your orders from dispatch to delivery.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 12),

            Text(
              'At PickNow, we aim to deliver not just products, but trust and satisfaction. Start shopping today and experience the joy of healthy living!',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
