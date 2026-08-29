import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sihati/core/utils/appcolors.dart';

class Notes extends StatelessWidget {
  const Notes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Appcolors.slider.withValues(alpha: .15),
      ),
      child: Center(
        child: Text(
          "Done".tr(),
          style: TextStyle(color: Appcolors.slider,fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
