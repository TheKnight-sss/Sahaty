import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';

class QuantityDividens extends StatelessWidget {
  const QuantityDividens({
    super.key, required this.ondelivery, required this.available, required this.unit,
  });
  final double ondelivery;
  final double available;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .1),
                  blurRadius: 1,
                  offset: Offset(1, 3),
                ),
              ],
            ),
            child: Center(
              child: Column(
                children: [
                  Text(
                    // 
                    "${ondelivery.toInt()}",
                    style: Style.loginSubTitle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Appcolors.l2,
                    ),
                  ),
                  Gap(5),
                  Text(
                    "On Delivery".tr(),
                    style: Style.subheader.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Gap(15),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .1),
                  blurRadius: 1,
                  offset: Offset(1, 3),
                ),
              ],
            ),
            child: Center(
              child: Column(
                children: [
                  Text(
                    available >= 1000
                        ? "${(available/ 1000).toInt()}K ${(unit).tr()}"
                        : "${available.toInt()} ${(unit).tr()}",
                    style: Style.loginSubTitle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Appcolors.l2,
                    ),
                  ),
                  Gap(5),
                  Text(
                    "Available".tr(),
                    style: Style.subheader.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
