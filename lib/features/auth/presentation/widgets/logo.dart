import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sihati/core/constants/app_images.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key, required this.logoColor,
  });

  final Color logoColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      height: 80,
      width: 80,
      child: Center(
        child: SvgPicture.asset(
          AppImages.logo,
          width: 40,
          height: 40,
          colorFilter: ColorFilter.mode(
            logoColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
