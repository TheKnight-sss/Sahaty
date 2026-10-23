import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/order/models/order_model.dart';
import 'package:sihati/features/order/presentation/cubit/order_cubit.dart';
import 'package:sihati/features/order/presentation/widgets/information_card.dart';
import 'package:sihati/features/order/presentation/widgets/product_order_list.dart';
import 'package:sihati/features/products/presentation/widgets/product_details_bar.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.order});

  final OrderModel order;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool edit = false;
  final List<TextEditingController> quantityControllers = [];

  @override
  void initState() {
    super.initState();

    for (final product in widget.order.orderlist!) {
      quantityControllers.add(
        TextEditingController(text: "${product.quantity ?? 0}"),
      );
    }
  }

  @override
  void dispose() {
    for (final controller in quantityControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = widget.order.orderlist ?? [];
    final statuscolor = widget.order.status == OrderStatus.onDelivering
        ? Appcolors.splashup
        : widget.order.status == OrderStatus.delivered
        ? Appcolors.slider
        : Colors.orange;
    final status = widget.order.status == OrderStatus.onDelivering
        ? "OnDelivering".tr()
        : widget.order.status == OrderStatus.delivered
        ? "Done".tr()
        : "Pending".tr();
    return Scaffold(
      appBar: ProductDetailsBar(
        title: "Order Details".tr(),
        edit: edit,
        onEditTap: () {
          setState(() {
            edit = true;
          });
        },
        onSaveTap: () async {
          final products = widget.order.orderlist ?? [];
          final cubit = context.read<OrderCubit>();

          final List<double> quantities = [];

          for (final controller in quantityControllers) {
            final quantity = double.tryParse(controller.text);

            if (quantity == null || quantity < 0) {
              return;
            }

            quantities.add(quantity);
          }
          for (int i = 0; i < products.length; i++) {
            await cubit.updateExistingOrderProductQuantity(
              widget.order,
              i,
              quantities[i],
            );
          }

          setState(() {
            edit = false;
          });
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Order Status".tr()),
                  Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statuscolor.withValues(alpha: .3),
                      borderRadius: BorderRadius.circular(15),
                      border: BoxBorder.all(
                        color: statuscolor.withValues(alpha: .5),
                      ),
                    ),
                    child: Center(
                      child: Text(status, style: TextStyle(color: statuscolor)),
                    ),
                  ),
                ],
              ),
              Gap(10),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Appcolors.l1,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total Order Amount".tr(),
                        style: TextStyle(color: Colors.white),
                      ),
                      Gap(1),
                      Text(
                        (widget.order.cost!.toInt()).toString(),
                        style: Style.splashTitle,
                      ),
                      Text("L.E".tr(), style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
              Gap(10),
              //!information card////////////////////////////////////////////////////
              InformationCard(
                name: widget.order.buyer.toString(),
                location: widget.order.location.toString(),
              ),
              //!productList//////////////////////////////////////////////////////////////
              Gap(10),
              ProductOrderList(
                products: products,
                edit: edit,
                quantityControllers: quantityControllers,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
