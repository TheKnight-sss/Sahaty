import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/dashboard/presentation/widgets/capacatiy.dart';

class InventoryCard extends StatelessWidget {
  const InventoryCard({
    super.key,
    required this.name,
    required this.remain,
    required this.color,
    required this.capacity,
    required this.ondeliverying,
    required this.max,
    required this.current, required this.parcolor,
  });
  final String name;

  // Remaining inventory
  final double remain;

  final Color color;

  // Current total inventory after delivered orders are removed
  final int capacity;

  // Quantity currently on delivery
  final int ondeliverying;

  // Current total inventory
  final double max;

  // Quantity currently on delivery
  final double current;

  final Color parcolor;
  @override
  Widget build(BuildContext context) {
    final percentage = max > 0 ? current / max : 0;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withValues(alpha: 0.1),
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Gap(10),
          Row(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: color.withValues(alpha: .15),
                    child: SvgPicture.asset(
                      AppImages.logo,
                      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                    ),
                  ),
                  Gap(5),
                  Text(name.tr(), style: Style.tab),
                ],
              ),
              Spacer(),
              Capacatiy(percentage: percentage),
            ],
          ),
          Gap(8),
          LinearProgressIndicator(
            minHeight: 8,
            value: max > 0 ? current / max : 0,
            backgroundColor: parcolor,
            valueColor: AlwaysStoppedAnimation<Color>(percentage>= .7 ?Appcolors.slider :percentage>= .3 ?Colors.orange : Colors.red ),
            borderRadius: BorderRadius.circular(16),
          ),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 10,
            children: [
              Column(
                children: [
                  Text(
                    "Total".tr(),
                    style: Style.tab.copyWith(
                      fontSize: 14,
                      color: Appcolors.slcard,
                    ),
                  ),
                  Text(capacity.toString(), style: Style.tab),
                ],
              ),
              Column(
                children: [
                  Text(
                    "On Delivery".tr(),
                    style: Style.tab.copyWith(
                      fontSize: 14,
                      color: Appcolors.slcard,
                    ),
                  ),
                  Text(
                    ondeliverying.toString(),
                    style: Style.tab.copyWith(color: Appcolors.l2),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Remaining".tr(),
                    style: Style.tab.copyWith(
                      fontSize: 14,
                      color: Appcolors.slcard,
                    ),
                  ),
                  Text(
                    remain.toString(),
                    style: Style.tab.copyWith(color: Appcolors.slider),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
