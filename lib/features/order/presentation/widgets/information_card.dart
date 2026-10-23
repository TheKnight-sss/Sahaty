import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';

class InformationCard extends StatelessWidget {
  const InformationCard({
    super.key, required this.name, required this.location,
  });
   final String name;
   final String location;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withValues(alpha: .1),
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                Icon(
                  Icons.person_outline_sharp,
                  color: Appcolors.l1,
                  size: 16,
                ),
                Gap(5),
                Text("Client Name".tr()),
                Spacer(),
                Text(
                  name,
                  style: Style.loginFieldLabel,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black.withValues(alpha: .1),
                ),
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppImages.map,
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(
                    Appcolors.location,
                    BlendMode.srcIn,
                  ),
                ),
                Gap(5),
                Text("Location".tr()),
                Spacer(),
                Text(
                  location,
                  style: Style.loginFieldLabel,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
