import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sihati/components/buttons/custom_button.dart';
import 'package:sihati/core/functions/dailog.dart';
import 'package:sihati/core/routes/navigation.dart';
import 'package:sihati/features/order/presentation/cubit/order_cubit.dart';
import 'package:sihati/features/order/presentation/cubit/order_state.dart';
import 'package:sihati/features/order/presentation/widgets/order_information_card.dart';
import 'package:sihati/features/order/presentation/widgets/order_item.dart';
import 'package:sihati/features/order/presentation/widgets/order_summary.dart';
import 'package:sihati/features/products/presentation/widgets/add_product_title.dart';

class AddOrderScreen extends StatelessWidget {
  const AddOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<OrderCubit>();
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
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
          child: AddBar(title: "Add Order", subtitle: "Add The Order Details"),
        ),
      ),
      body: BlocListener<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is OrderLoading) {
            showLoadingDialog(context);
          } else if (state is OrderSuccess) {
            pop(context);
            showMyDialog(
              context,
              "Item Add Successfully",
              type: DialogType.success,
            );
          } else if (state is OrderFailure) {
            pop(context);
            showMyDialog(context, state.message, type: DialogType.error);
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: cubit.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //!part1
                OrderInformationCard(),
                //!part2
                OrderItem(),
                //!part3
                OrderSummary(),
                CustomButton(
                  onPressed: () {
                    cubit.addOrder(
                      context,
                      cubit.buyercontroller.text,
                      cubit.locationcontroller.text,
                      cubit.repcontroller.text,
                    );
                  },
                  color1: Color(0xff2563EB),
                  color2: Color(0xff1D4ED8),
                  color3: Color(0xff1E40AF),
                  child: Text(
                    "Add Order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
