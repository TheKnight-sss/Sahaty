import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sihati/features/products/presentation/widgets/head.dart';

class OrderField extends StatelessWidget {
   const OrderField({
    super.key, required this.head, required this.hintText, this.prefixIcon,required this.controller,
  });
  final String head;
  final String hintText;
  final Widget? prefixIcon;
  final TextEditingController controller ;

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
          controller: controller,
        ),
      ],
    );
  }
}
