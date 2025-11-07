import 'package:flutter/material.dart';
import 'package:picknow/costants/theme/appcolors.dart';
import '../../../costants/mediaquery/mediaquery.dart';

class VendorsList extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const VendorsList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mediaqueryheight(0.2, context),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            productName: product['name'],
            imageUrl: product['imageUrl'],
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String imageUrl;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.productName,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      width: mediaquerywidth(0.4, context),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: AppColors.orange,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
          
            children: [
              ClipRRect(
                 borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/img$imageUrl.png",
                  color: AppColors.grey,
                  height: mediaqueryheight(0.13, context),
                  width: mediaquerywidth(0.28, context),
                  fit: BoxFit.cover,
                
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Center(
                  child: Text(
                    productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
