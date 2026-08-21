import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sihati/core/utils/style.dart';

class Price extends StatelessWidget {
  const Price({
    super.key,
    required this.selectedUnit,
  });

  final String selectedUnit;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Price/'.tr(),
            style: Style.loginFieldLabel.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: selectedUnit,
            style: Style.loginFieldLabel.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: '(L.E)'.tr(),
            style: Style.loginFieldLabel.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: ' *',
            style: Style.loginFieldLabel.copyWith(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
