import 'package:flutter/material.dart';
import 'package:sihati/core/utils/style.dart';

class Head extends StatelessWidget {
  const Head({
    super.key, required this.head,
  });
  final String head;

  @override
  Widget build(BuildContext context) {
    return RichText(
    text:  TextSpan(
        children: [
          TextSpan(
            text: head,
            style: Style.loginFieldLabel.copyWith(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: ' *',
            style: Style.loginFieldLabel.copyWith(
              color: Colors.red,
            ),
          ),
        ]
      )
    );
  }
}
