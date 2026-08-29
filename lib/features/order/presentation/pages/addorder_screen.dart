import 'package:flutter/material.dart';
import 'package:sihati/features/products/presentation/widgets/add_product_title.dart';

class AddOrderScreen extends StatelessWidget {
  const AddOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff2563EB), Color(0xff1D4ED8)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: AddBar(title: "Add Order",subtitle: "Add The Order Details",),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("hello")
        ],
      ),
    );
  }
}