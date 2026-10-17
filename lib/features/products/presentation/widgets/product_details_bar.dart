import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';

class ProductDetailsBar extends StatefulWidget implements PreferredSizeWidget {
  const ProductDetailsBar({
    super.key,
    required this.edit,
    required this.onEditTap,
    required this.onSaveTap, required this.title,
  });

  final bool edit;
  final VoidCallback onEditTap;
  final VoidCallback onSaveTap;
  final String title;

  @override
  State<ProductDetailsBar> createState() => _ProductDetailsBarState();

  @override
  Size get preferredSize => const Size.fromHeight(76);
}

class _ProductDetailsBarState extends State<ProductDetailsBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(76),
      child: Container(
        decoration: BoxDecoration(
          color: Appcolors.l1,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(right: 5, left: 5, bottom: 10),
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .2),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              title: Text(
                widget.title,
                style: Style.loginFieldLabel.copyWith(color: Colors.white),
              ),
              subtitle: Text(
                widget.title,
                style: TextStyle(
                  color: Color(0xFFBFDBFE),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: InkWell(
                onTap: widget.edit ? widget.onSaveTap : widget.onEditTap,
                child: Container(
                  height: 30,
                  width: 90,
                  decoration: BoxDecoration(
                    color: widget.edit
                        ? Appcolors.slider
                        : Colors.white.withValues(alpha: .2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.rotate(
                          angle: context.locale.languageCode == 'en'
                              ? 260 * 3.14 / 180
                              : 0,
                          child: Icon(
                            widget.edit
                                ? Icons.save_outlined
                                : Icons.edit_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        Gap(10),
                        Transform.translate(
                          offset: context.locale.languageCode == 'en'
                              ? Offset(-10, 0)
                              : Offset(10, 0),
                          child: Text(
                            widget.edit ? "Save".tr() : "Edit".tr(),
                            style: Style.subheader.copyWith(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
