import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sihati/features/products/presentation/widgets/head.dart';

class HeadList extends StatelessWidget {
  const HeadList({
    super.key, required this.head, required this.hintText, this.prefixIcon,
  });
  final String head;
  final String hintText;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Head(head: head),
        Gap(10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
            prefixIcon: prefixIcon,
          ),
        ),
      ],
    );
  }
}
