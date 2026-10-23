import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sihati/features/order/models/order_item_model.dart';
import 'package:sihati/features/order/presentation/widgets/product_order_card.dart';

class ProductOrderList extends StatelessWidget {
  const ProductOrderList({
    super.key,
    required this.products,
    required this.edit,
    required this.quantityControllers,
  });

  final List<OrderItemModel> products;
  final bool edit;
  final List<TextEditingController> quantityControllers;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withValues(alpha: .1),
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 3, child: Text("Product Name".tr())),
              Expanded(flex: 2, child: Text("Quantity".tr())),
              Expanded(flex: 2, child: Text("Quantity Price".tr())),
            ],
          ),
          Gap(10),
          ListView.separated(
            separatorBuilder: (context, index) => const Gap(20),
            itemCount: products.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final product = products[index];
              final productname = product.name;
              final productprice = product.price;
              final productquantity = product.quantity;
              final productcolor = product.color;

              return ProductOrderCard(
                productcolor: productcolor,
                productname: productname,
                edit: edit,
                quantityControllers: quantityControllers,
                productquantity: productquantity,
                productprice: productprice,
                index: index,
              );
            },
          ),
        ],
      ),
    );
  }
}
