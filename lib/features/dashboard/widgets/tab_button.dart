import 'package:flutter/material.dart';
import 'package:sihati/core/utils/style.dart';

class TabButton extends StatelessWidget {
  const TabButton({super.key, required this.text, this.onpressed, this.bg, this.fr, this.elev});

  final String text;
  final VoidCallback? onpressed;
  final Color? bg;
  final Color? fr;
  final double? elev;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fr,
          elevation:elev ,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, 40),
        ),
        
        child: Text(text, style: Style.tab),
      ),
    );
  }
}
