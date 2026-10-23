import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sihati/features/order/presentation/cubit/order_cubit.dart';
import 'package:sihati/features/products/models/product_model.dart';
import 'package:sihati/features/products/presentation/cubit/product_cubit.dart';
import 'package:sihati/features/products/presentation/widgets/add_quantity_to_stock.dart';
import 'package:sihati/features/products/presentation/widgets/product_details_bar.dart';
import 'package:sihati/features/products/presentation/widgets/product_details_card.dart';
import 'package:sihati/features/products/presentation/widgets/product_precentage.dart';
import 'package:sihati/features/products/presentation/widgets/quantity_dividens.dart';
import 'package:sihati/features/products/presentation/widgets/total_amount.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final TextEditingController nameController;
  late final TextEditingController priceController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.product.name ?? '');

    priceController = TextEditingController(
      text: widget.product.price.toString(),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  bool edit = false;
  @override
  Widget build(BuildContext context) {
    final quantityController = TextEditingController();
    final orderCubit = context.read<OrderCubit>();
    final productcubit = context.read<ProductCubit>();

    final onDelivery = orderCubit.getProductOnDelivery(widget.product.name);
    final delivered = orderCubit.getProductDelivered(widget.product.name);

    final max = widget.product.capacity ?? 0;

    final currentTotal = widget.product.quantity ?? 0 - delivered;

    final remaining = currentTotal - onDelivery;

    final percentage = max > 0 ? currentTotal / max : 0;
    return Scaffold(
      appBar: ProductDetailsBar(
        title: "Product Details".tr(),
        edit: edit,
        onEditTap: () {
          setState(() {
            edit = true;
          });
        },
        onSaveTap: () {
          productcubit.updateProduct(
            productId: widget.product.id!,
            name: nameController.text,
            price: double.tryParse(priceController.text),
          );
        },
      ),
      //!Body///////////////////////////////////////////////////////////////////////////////////////
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProductPrecentage(
                  namecontroller: nameController,
                  edit: edit,
                  percentage: percentage,
                  product: widget.product,
                  remain: remaining,
                ),
                Gap(20),
                ProductDetailsCard(
                  widget: widget,
                  remain: remaining,
                  edit: edit,
                  pricecontroller: priceController,
                ),
                Gap(20),
                //!-------------------------------------------------------------\\
                TotalAmount(
                  remain: remaining,
                  color: widget.product.color!,
                  price: widget.product.price!,
                ),
                Gap(20),
                //!---------------------------------------------------------------------------------\\
                QuantityDividens(
                  available: currentTotal.toDouble(),
                  ondelivery: onDelivery,
                  unit: widget.product.unit!,
                ),
                Gap(20),
                AddQuantityToStock(
                  quantityController: quantityController,
                  productId: widget.product.id!,
                  unit: widget.product.unit!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
