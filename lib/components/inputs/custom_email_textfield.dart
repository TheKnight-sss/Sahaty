import 'package:flutter/material.dart';

class CustomEmailTextfield extends StatelessWidget {
  const CustomEmailTextfield({super.key, this.hint, this.controller, this.val});
  final String? hint;
  final TextEditingController? controller;
  final String? val;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator:(value) {
        if (value == null || value.isEmpty) {
          return val;          
        }
        return null;
      },
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      maxLines: 1,
      textAlign: TextAlign.end,
      style: const TextStyle(
        fontSize: 20,
      ),      
    );
  }
}
