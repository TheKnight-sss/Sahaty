import 'package:flutter/material.dart';
import 'package:sihati/core/constants/app_fonts.dart';
import 'package:sihati/core/utils/appcolors.dart';

class AppTheme{
  static ThemeData get lightTheme => ThemeData(
    fontFamily: AppFonts.cairo,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor:Appcolors.field,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),

      hintStyle: TextStyle(
        color: Colors.grey.shade500,
        fontSize: 16,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Appcolors.login,
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      
    )
  );
}