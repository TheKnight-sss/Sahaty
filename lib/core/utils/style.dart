import 'package:flutter/material.dart';
import 'package:sihati/core/constants/app_fonts.dart';
import 'package:sihati/core/utils/appcolors.dart';

class Style {
  static const TextStyle splashTitle = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: AppFonts.cairo,
    decoration: TextDecoration.none,
  );
  static const TextStyle loginTitle = TextStyle(
    fontSize: 40,
    color: Colors.black,
    fontFamily: AppFonts.cairo,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
  );
  static const TextStyle loginSubTitle = TextStyle(
    fontSize: 24,
    color: Appcolors.logsubtitle,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle loginFieldLabel = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Color(0xFF333333),
  );
}
