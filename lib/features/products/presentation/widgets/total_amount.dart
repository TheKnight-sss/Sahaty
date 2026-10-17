import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/product_color.dart';
import 'package:sihati/core/utils/style.dart';


class TotalAmount extends StatelessWidget {
  const TotalAmount({
    super.key,
    required this.color,
    required this.remain,
    required this.price,
  });

  final String color;
  final double remain;
  final double price;

  @override
  Widget build(BuildContext context) {
    final total = remain * price;
    final formattedTotal = total / 1000;
    final finalformattedTotal = formattedTotal == formattedTotal.toInt()
        ? formattedTotal.toInt().toString()
        : formattedTotal.toStringAsFixed(1);
    return Container(
      decoration: BoxDecoration(
        color: getProductColor(color).withValues(alpha: .1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            SvgPicture.asset(
              AppImages.tag,
              colorFilter: ColorFilter.mode(
                getProductColor(color),
                BlendMode.srcIn,
              ),
            ),
            Gap(10),
            Text(
              "Total Amount Price".tr(),
              style: Style.subheader.copyWith(
                fontWeight: FontWeight.w600,
                color: getProductColor(color),
              ),
            ),
            Spacer(),
            Text(
              total >= 1000
                  ? "${finalformattedTotal.tr()} ${"k".tr()} ${"L.E".tr()}"
                  : "${total.toInt()} ${"L.E".tr()}",
              style: Style.subheader.copyWith(
                fontWeight: FontWeight.w600,
                color: getProductColor(color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
