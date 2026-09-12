import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/order/presentation/cubit/order_cubit.dart';

class OrderItemCard extends StatefulWidget {
  const OrderItemCard({
    super.key,
    required this.orderproductname,
    this.orderproductprice,
    this.orderproductquantity,
    this.orderproductunit,
    required this.productcolor,
    required this.onpressed,
    required this.index,
  });

  final String orderproductname;
  final int index;
  final double? orderproductprice;
  final double? orderproductquantity;
  final String? orderproductunit;
  final Color productcolor;
  final VoidCallback onpressed;

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  late final TextEditingController orderproductquantitycontroller;

  @override
  void initState() {
    super.initState();

    orderproductquantitycontroller = TextEditingController(
      text: widget.orderproductquantity?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    orderproductquantitycontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quantity = double.tryParse(orderproductquantitycontroller.text) ?? 0;

    final totalprice = (widget.orderproductprice ?? 0) * quantity;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppImages.logo,
                    width: 40,
                    height: 40,
                    colorFilter: ColorFilter.mode(
                      widget.productcolor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),

              const Gap(5),
              Text(
                widget.orderproductname,
                style: Style.loginFieldLabel.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: widget.onpressed,
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          Transform.translate(offset: Offset(-50, -18),
            child: Text(
              "Price: $totalprice",
              style: Style.loginFieldLabel.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
          ),
          Row(
            children: [
              Text(
                "Quantity",
                style: Style.loginFieldLabel.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Gap(5),
              Expanded(
                child: TextField(
                  controller: orderproductquantitycontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter quantity',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                  ),
                  onChanged: (value) {
                    final quantity = double.tryParse(value) ?? 0;

                    context.read<OrderCubit>().updateProductQuantity(
                      widget.index,
                      quantity,
                    );

                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
