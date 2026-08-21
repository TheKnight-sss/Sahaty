import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AddProductButton extends StatelessWidget {
  const AddProductButton({
    super.key, required this.onpressed,
  });
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff2563EB),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: RichText(text: TextSpan(
          children: [
            WidgetSpan(
              child: Icon(Icons.add, color: Colors.white, size: 20),
            ),         
            TextSpan(text: ' '),           
            TextSpan(
              text: 'Add Product To Stock'.tr(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ]
        ))
      ),
    );
  }
}
