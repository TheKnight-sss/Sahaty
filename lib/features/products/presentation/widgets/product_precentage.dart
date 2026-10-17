import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/product_color.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/dashboard/presentation/widgets/capacatiy.dart';
import 'package:sihati/features/products/models/product_model.dart';

class ProductPrecentage extends StatelessWidget {
  const ProductPrecentage({
    super.key,
    required this.percentage, required this.product, required this.remain, required this.edit, required this.namecontroller,
  });

  final num percentage;

  final ProductModel product;

  final double remain;

  final bool edit;
  final TextEditingController namecontroller;

  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getProductColor(
          product.color,
        ).withValues(alpha: .1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              height: 100,
              width: 60,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .1),
                    blurRadius: 1,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: SvgPicture.asset(
                fit: BoxFit.contain,
                AppImages.logo,
                colorFilter: ColorFilter.mode(
                  getProductColor(product.color),
                  BlendMode.srcIn,
                ),
              ),
            ),
            title: edit? TextField(controller: namecontroller ,) : Text(
              "${product.name}",
              style: Style.loginSubTitle.copyWith(
                color: getProductColor(product.color),
                fontWeight: FontWeight.w400,
              ),
            ) ,
            subtitle: Row(
              children: [
                Text("Remaining Quantity".tr()),
                Text(remain.toStringAsFixed(1)),
              ],
            ),
            trailing: SizedBox(
              height: 30,
              child: Capacatiy(
                borderRadius: BorderRadius.circular(15),
                percentage: percentage,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                LinearProgressIndicator(
                  minHeight: 8,
                  value: 20,
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    percentage >= .7
                        ? Appcolors.slider
                        : percentage >= .3
                        ? Colors.orange
                        : Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                const Gap(4),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '0',
                      style: Style.subheader.copyWith(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Remain'.tr(),
                            style: Style.subheader.copyWith(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' ${(percentage*100).toStringAsFixed(0)}%',
                            style: Style.subheader.copyWith(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${product.capacity!.toInt()}',
                      style: Style.subheader.copyWith(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Gap(10),
              ],
            ),
          ),
          Gap(10),
        ],
      ),
    );
  }
}
