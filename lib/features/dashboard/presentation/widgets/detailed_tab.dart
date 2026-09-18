import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DetailedTab extends StatelessWidget {
  const DetailedTab({super.key, required this.subtitle, required this.txt});

  final String txt;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              txt,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFFBFDBFE), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
