import 'package:flutter/material.dart';
import 'package:picknow/core/costants/navigation/navigation.dart';
import 'package:picknow/core/costants/theme/appcolors.dart';
import 'package:picknow/views/products/products_gridview.dart';

class Productsview extends StatelessWidget {
  final String name;
  final String categoryid;
  const Productsview({super.key, required this.name,required this.categoryid});

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
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.lightgrey),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 20,
                ))),
        title: Text(name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ProductsGridview(
              categoryId: categoryid,
              isfromcatogory: true,
            ),
          ),
        ],
      ),
    );
  }
}
