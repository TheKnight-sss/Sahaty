import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/appcolors.dart';

enum DialogType { success, error, warning }

void showMyDialog(
  BuildContext context,
  String message, {
  DialogType type = DialogType.error,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: type == DialogType.success
          ? Colors.green
          : type == DialogType.error
          ? Colors.red
          : Colors.orange,
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
    ),
  );
}

void showLoadingDialog(BuildContext context) {
  debugPrint("showLoadingDialog()");
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          width: 220,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                AppImages.loading,
                delegates: LottieDelegates(
                  values: [
                    ValueDelegate.color(const ['**'], value: Appcolors.l2),
                  ],
                ),
                width: 120,
                height: 120,
                fit: BoxFit.contain,
                repeat: true,
              ),
              SizedBox(height: 12),
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  decoration: TextDecoration.none
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
