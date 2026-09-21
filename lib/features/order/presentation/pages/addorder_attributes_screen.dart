import 'package:flutter/material.dart';
import 'package:sihati/components/buttons/custom_button.dart';
import 'package:sihati/core/utils/appcolors.dart';

class AddorderAttributesScreen extends StatefulWidget {
  const AddorderAttributesScreen({super.key});

  @override
  State<AddorderAttributesScreen> createState() =>
      _AddorderAttributesScreenState();
}

class _AddorderAttributesScreenState extends State<AddorderAttributesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Attributes"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: CustomButton(
              onPressed: () {},
              color1: Appcolors.splashup,
              color2: Appcolors.splashcenter,
              color3: Appcolors.splashup,
              child: Text("Add Buyer"),
            ),
          ),
        ],
      ),
    );
  }
}
