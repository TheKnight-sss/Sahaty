import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/features/order/models/order_model.dart';
import 'package:sihati/features/products/presentation/widgets/product_details_bar.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    bool edit = false;

    final statuscolor = order.status == OrderStatus.onDelivering
        ? Appcolors.splashup
        : order.status == OrderStatus.delivered
        ? Colors.green
        : Colors.orange;
    return Scaffold(
      appBar: ProductDetailsBar(
        title: "Order Details",
        edit: edit,
        onEditTap: () {},
        onSaveTap: () {},
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Text("Order Status".tr()),
                Spacer(),
                Container(
                  padding:const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: BoxBorder.all(color: statuscolor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
