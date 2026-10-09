import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/products/presentation/pages/product_details_screen.dart';

class ProductDetailsCard extends StatelessWidget {
  const ProductDetailsCard({
    super.key,
    required this.widget,
  });

  final ProductDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black.withValues(alpha: .1),
            offset: Offset(0, 3),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black.withValues(alpha: .1),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppImages.layers,
                  colorFilter: ColorFilter.mode(
                    Appcolors.l1,
                    BlendMode.srcIn,
                  ),
                ),
                Gap(10),
                Text(
                  "Total Amount".tr(),
                  style: Style.subheader.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Text(
                  "${widget.product.capacity} ${widget.product.unit!.tr()}",
                  style: Style.subheader.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          //!-----------------------------------------------------
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black.withValues(alpha: .1),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppImages.dollar,
                  colorFilter: ColorFilter.mode(
                    Appcolors.signinbg,
                    BlendMode.srcIn,
                  ),
                ),
                Gap(10),
                Text(
                  "Price/ ${widget.product.unit!.tr()}".tr(),
                  style: Style.subheader.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Text(
                  "${widget.product.price} ${"L.E".tr()}",
                  style: Style.subheader.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          //!----------------------------------------------------
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppImages.alert,
                  colorFilter: ColorFilter.mode(
                    Colors.yellow,
                    BlendMode.srcIn,
                  ),
                ),
                Gap(10),
                Text(
                  "Total Amount".tr(),
                  style: Style.subheader.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Text(
                  "${(widget.product.capacity??0)*.25} ${widget.product.unit!.tr()}",
                  style: Style.subheader.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
