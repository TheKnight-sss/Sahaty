import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/order/presentation/cubit/order_cubit.dart';
import 'package:sihati/features/order/presentation/cubit/order_state.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(AppImages.wallet, width: 45, height: 45),
                Text("Order Summary", style: Style.loginFieldLabel)
              ],
            ), 
            Gap(10),
            BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                final orderCubit = context.read<OrderCubit>();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Items: ",style: Style.loginFieldLabel,
                      
                    ),
                    Text(
                      "Total Price: ",style: Style.loginFieldLabel,
                      
                    ),
                  ],
                );
              },
            ),                  
          ],
        ),
      ),
    );
  }
}
