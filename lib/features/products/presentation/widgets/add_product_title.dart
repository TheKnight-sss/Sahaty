import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sihati/core/functions/extension.dart';
import 'package:sihati/core/utils/style.dart';

class AddProductTitle extends StatelessWidget {
  const AddProductTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: SizedBox(
          height: 40,
          width: 40,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.15),
            ),
            child: Center(
              child: Transform.translate(
                offset: context.isArabic ? Offset(-1, 0) : Offset(4, 0),
                child: Icon(
                  context.isArabic
                      ? Icons.arrow_forward_ios
                      : Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ),
      title: Text(
        'Add Product'.tr(),
        style: Style.loginSubTitle.copyWith(color: Colors.white),
      ),
      subtitle: Text(
        'Add your product details'.tr(),
        style: Style.subheader,
      ),
    );
  }
}
