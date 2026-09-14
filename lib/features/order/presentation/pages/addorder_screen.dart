import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sihati/components/buttons/custom_button.dart';
import 'package:sihati/core/functions/dailog.dart';
import 'package:sihati/core/routes/navigation.dart';
import 'package:sihati/core/routes/routes.dart';
import 'package:sihati/features/order/presentation/cubit/order_cubit.dart';
import 'package:sihati/features/order/presentation/cubit/order_state.dart';
import 'package:sihati/features/order/presentation/widgets/order_item_list.dart';
import 'package:sihati/features/order/presentation/widgets/order_information_card.dart';
import 'package:sihati/features/order/presentation/widgets/order_summary.dart';
import 'package:sihati/features/products/presentation/widgets/add_product_title.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  @override
  void initState() {
    super.initState();

    context.read<OrderCubit>().resetOrder();
  }

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
            pop(context); // close loading dialog

            pushReplacementTo(context, Routes.dashboard);
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
                OrderItemList(),
                //!part3
                OrderSummary(),
                CustomButton(
                  onPressed: () {
                    cubit.addOrder();
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
