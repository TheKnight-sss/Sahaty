import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/appcolors.dart';

class Notes extends StatelessWidget {
  const Notes({super.key, required this.text, required this.select});

  final String text;
  final bool select;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Appcolors.slider.withValues(alpha: .15),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (select) ...[
              SvgPicture.asset(
                AppImages.check,
                width: 14,
                height: 14,
                colorFilter: ColorFilter.mode(
                  Appcolors.slider,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 0),
            ],
            Text(
              text.tr(),
              style: TextStyle(
                color: Appcolors.slider,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
