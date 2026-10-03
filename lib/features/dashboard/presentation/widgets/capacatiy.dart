import 'package:flutter/material.dart';
import 'package:sihati/core/utils/appcolors.dart';

class Capacatiy extends StatelessWidget {
  const Capacatiy({
    super.key,
    required this.percentage, this.borderRadius,
  });

  final num percentage;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: 60,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(50),
        color:percentage>= .7 ?Appcolors.slider.withValues(alpha: .15) :percentage>= .3 ?Colors.orange.withValues(alpha: .15) : Colors.red.withValues(alpha: .15),
      ),
      child: Center(
        child: Text(
          percentage>= .7 ?"Ok" :percentage>= .3 ?"Good" : "Low",
          style: TextStyle(
            color: percentage>= .7 ?Appcolors.slider :percentage>= .3 ?Colors.orange : Colors.red,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
