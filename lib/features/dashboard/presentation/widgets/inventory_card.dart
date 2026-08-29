import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';

class InventoryCard extends StatelessWidget {
  const InventoryCard({
    super.key, required this.name, required this.remain, required this.color,
  });
  final String name;
  final double remain;
  final Color color;

  @override
  Widget build(BuildContext context) {
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
                    backgroundColor:color.withValues(
                      alpha: .15,
                    ),
                    child: SvgPicture.asset(
                      AppImages.logo,
                      colorFilter: ColorFilter.mode(
                        color,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  Gap(5),
                  Text(name.tr(), style: Style.tab),
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(5),
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Appcolors.slider.withValues(alpha: .15),
                ),
                child: Center(
                  child: Text(
                    "Ok".tr(),
                    style: TextStyle(color: Appcolors.slider,fontWeight:FontWeight.w700 ),
                  ),
                ),
              ),
            ],
          ),
          Gap(8),
          LinearProgressIndicator(
            minHeight: 8,
            value: 0 / 2000,
            backgroundColor: Appcolors.slider,
            borderRadius: BorderRadius.circular(16),
          ),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 10,
            children: [
              Column(
                children: [
                  Text("Total".tr(),style: Style.tab.copyWith(fontSize: 14,color: Appcolors.slcard),),
                  Text("450kg",style: Style.tab,)
                ],
              ),
              Column(
                children: [
                  Text("On Delivery".tr(),style: Style.tab.copyWith(fontSize: 14,color: Appcolors.slcard)),
                  Text("30kg",style: Style.tab.copyWith(color: Appcolors.l2),)
                ],
              ),
              Column(
                children: [
                  Text("Remaining".tr(),style: Style.tab.copyWith(fontSize: 14,color: Appcolors.slcard),),
                  Text(remain.toString(),style: Style.tab.copyWith(color: Appcolors.slider),)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
