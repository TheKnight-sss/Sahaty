import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                blurRadius: 24,
                color: Colors.black.withValues(alpha: 0.1),
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text("El Asel", style: Style.tab),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(5),
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Appcolors.signinbg.withValues(
                        alpha: .3,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Enough".tr(),
                        style: TextStyle(
                          color: Appcolors.signinbg,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                SvgPicture.asset(AppImages.map,colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),width: 15,),
                Gap(3),
                Text("القاهرة")
              ],)
            ],
          ),
        ),
    );
  }
}
