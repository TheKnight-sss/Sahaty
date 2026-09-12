import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/routes/navigation.dart';
import 'package:sihati/core/routes/routes.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/order/presentation/cubit/order_cubit.dart';
import 'package:sihati/features/order/presentation/cubit/order_state.dart';
import 'package:sihati/features/order/presentation/widgets/order_item_card.dart';

class OrderItemList extends StatelessWidget {
  const OrderItemList({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = {
      'Green': Colors.green,
      'Blue': Colors.blue,
      'Orange': Colors.orange,
      'Purple': Colors.purple,
      'Pink': Colors.pink,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            var cubit = context.read<OrderCubit>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppImages.cart, width: 48, height: 48),
                    Gap(8),
                    Text(
                      'Order Products'.tr(),
                      style: Style.loginFieldLabel.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        pushTo(context, Routes.selectorderitem);
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Appcolors.signinbg,
                      ),
                    ),
                  ],
                ),
                Gap(10),
                (cubit.selectedOrderItems.isNotEmpty)
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final order = cubit.selectedOrderItems[index];
                          return OrderItemCard(
                            index: index,
                            orderproductname: order.name ?? '',
                            orderproductquantity: order.quantity,
                            orderproductprice: order.price??0,
                            orderproductunit: order.unit ?? '',
                            productcolor: colors[order.color]!,
                            onpressed: () {
                              cubit.removeProductFromOrder(index);
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Gap(10);
                        },
                        itemCount: cubit.selectedOrderItems.length,
                      )
                    : SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }
}
