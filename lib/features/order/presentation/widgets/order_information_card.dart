import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/order/presentation/cubit/order_cubit.dart';
import 'package:sihati/features/order/presentation/widgets/order_field.dart';

class OrderInformationCard extends StatelessWidget {
   const OrderInformationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<OrderCubit>();
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppImages.clipboard,
                  width: 48,
                  height: 48,
                ),
                Gap(8),
                Text(
                  'Order Information'.tr(),
                  style: Style.loginFieldLabel.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            Gap(10),
            OrderField(
              head: "Buyer",
              hintText: 'Enter Buyer Name'.tr(),
              prefixIcon: Icon(Icons.person_outline_sharp),
              controller: cubit.buyercontroller,
            ),
            Gap(15),
            OrderField(
              head: 'Location',
              hintText: 'Enter Location'.tr(),
              prefixIcon: Icon(Icons.location_on_outlined),
              controller: cubit.locationcontroller,
            ),
            Gap(15),
            OrderField(
              head: 'Representative',
              hintText: 'Enter Representative Name'.tr(),
              prefixIcon: Icon(Icons.person_outline_sharp),
              controller: cubit.repcontroller,
            ),
          ],
        ),
      ),
    );
  }
}
