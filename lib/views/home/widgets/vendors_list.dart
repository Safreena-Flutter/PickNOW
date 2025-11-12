// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:picknow/costants/theme/appcolors.dart';
import '../../../costants/mediaquery/mediaquery.dart';
import '../../../costants/navigation/navigation.dart';
import '../../products/gird_view.dart';

class InfoList extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const InfoList({super.key, required this.products});

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

  const ProductCard({
    super.key,
    required this.productName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(right: 13),
      child: Column(
        children: [
          Card(
            color: AppColors.lightgrey2,
            shape: CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(
                "assets/images/img$imageUrl.png",
                height: mediaqueryheight(0.09, context),
                width: mediaquerywidth(0.2, context),
                color: AppColors.orange,
              ),
            ),
          ),
          SizedBox(
            width: mediaquerywidth(0.4, context),
            child: Text(
              productName,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class VendorsList extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const VendorsList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mediaqueryheight(0.13, context),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return VendorProductCard(
            productName: product['name'],
            imageUrl: product['imageUrl'],
            brandid: product['id'],
          );
        },
      ),
    );
  }
}

class VendorProductCard extends StatelessWidget {
  final String productName;
  final String imageUrl;
  final String brandid;

  const VendorProductCard(
      {super.key,
      required this.productName,
      required this.imageUrl,
      required this.brandid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          PageNavigations().push(Productsview(
            isfrombrand: true,
            name: productName,
            brandId: productName,
          ));
        },
        child: Column(
          children: [
            Image.network(
              imageUrl,
              height: mediaqueryheight(0.09, context),
              width: mediaquerywidth(0.2, context),
            ),
            SizedBox(
              width: mediaquerywidth(0.4, context),
              child: Text(
                productName,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }
}
