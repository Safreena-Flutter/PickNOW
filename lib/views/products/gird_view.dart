import 'package:flutter/material.dart';
import 'package:picknow/costants/navigation/navigation.dart';
import 'package:picknow/costants/theme/appcolors.dart';
import 'package:picknow/views/products/products_gridview.dart';

class Productsview extends StatelessWidget {
  final String name;
  final String? categoryid;
  final String? brandId;
  final bool? isfrombrand;
final bool? isfromcategory;
  const Productsview({super.key, required this.name,  this.categoryid, this.brandId,this.isfrombrand,this.isfromcategory});

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
              isfromcatogory:isfromcategory,
              brandId: brandId,
              categoryname: name,
              isfrombrand: isfrombrand,
            ),
          ),
        ],
      ),
    );
  }
}
