import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/products/models/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
    bool edit = false;

  Color getProductColor(String? color) {
    switch (color) {
      case 'Green':
        return Colors.green;

      case 'Blue':
        return Colors.blue;

      case 'Orange':
        return Colors.orange;

      case 'Purple':
        return Colors.purple;

      case 'Pink':
        return Colors.pink;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detailes"),
        centerTitle: true,
        actions: [TextButton(onPressed: () {
          setState(() {
            edit == true;
          });
        }, child: Text("Edit",style: TextStyle(fontSize: 20),))],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: 150,
                  height: 150,
                  color: Appcolors.slcard.withValues(alpha: .2),
                  child: SvgPicture.asset(
                    AppImages.logo,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      getProductColor(widget.product.color),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Gap(20),
              Text(
                widget.product.name ?? "",
                style: Style.header.copyWith(color: Colors.black),
              ),
              Gap(20),
              Text(
                "Price  :  ${widget.product.price}",
                style: Style.header.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
