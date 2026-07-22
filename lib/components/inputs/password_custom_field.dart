import 'package:flutter/material.dart';

class PasswordCustomField extends StatefulWidget {
  const PasswordCustomField({
    super.key, this.controller, this.val,
  });
  final String? val;
  final TextEditingController? controller;

  @override
  State<PasswordCustomField> createState() => _PasswordCustomFieldState();
}

class _PasswordCustomFieldState extends State<PasswordCustomField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: "********",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "برجاء إدخال الرقم السري";          
        }
        return null;
      },
      obscureText: _obscureText,
      maxLines: 1,
      textAlign: TextAlign.end,
      style: const TextStyle(fontSize: 20),
    );
  }
}
