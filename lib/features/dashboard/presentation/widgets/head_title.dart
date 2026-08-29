import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/functions/extension.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/dashboard/presentation/widgets/detailed_tab.dart';

class HeadTitle extends StatelessWidget {
  const HeadTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff2563EB), Color(0xff1D4ED8)],
        ),
    
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .2),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sahaty'.tr(), style: Style.header),
              IconButton(
                onPressed: () {
                  context.setLocale(
                    context.isArabic ? const Locale("en") : Locale("ar"),
                  );
                },
                icon: Icon(
                  Icons.language_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
          Gap(5),
          Text(
            "Inventory and Orders Dashboard".tr(),
            style: Style.subheader,
          ),
          Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 10,
            children: [DetailedTab(), DetailedTab(), DetailedTab()],
          ),
        ],
      ),
    );
  }
}
