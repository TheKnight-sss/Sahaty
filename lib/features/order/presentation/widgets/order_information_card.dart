import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/order/models/buyer_model.dart';
import 'package:sihati/features/order/presentation/cubit/buyer_state.dart';
import 'package:sihati/features/order/presentation/cubit/order_cubit.dart';
import 'package:sihati/features/order/presentation/cubit/person_cubit.dart';
import 'package:sihati/features/products/presentation/widgets/head.dart';

class OrderInformationCard extends StatefulWidget {
  const OrderInformationCard({super.key});

  @override
  State<OrderInformationCard> createState() => _OrderInformationCardState();
}

class _OrderInformationCardState extends State<OrderInformationCard> {
  @override
  void initState() {
    super.initState();

    context.read<PersonCubit>().getBuyers();
    context.read<PersonCubit>().getReps();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<OrderCubit>();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocBuilder<PersonCubit, PersonState>(
        builder: (context, state) {
          final personcubit = context.read<PersonCubit>();
          return Container(
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
                Head(head: "Buyer"),
                Gap(5),
                DropdownButtonFormField<BuyerModel>(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Select Buyer'.tr(),
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                  items: personcubit.buyersList.map((buyer) {
                    return DropdownMenuItem<BuyerModel>(
                      value: buyer,
                      child: Text(buyer.name),
                    );
                  }).toList(),
                  onChanged: (buyer) {
                    if (buyer != null) {
                      cubit.buyercontroller.text = buyer.name;
                      cubit.locationcontroller.text = buyer.location;
                    }
                  },
                ),
                Gap(15),
                Head(head: "Location"),
                TextField(
                  controller: cubit.locationcontroller,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: cubit.locationcontroller.text,
                    prefixIcon: Icon(Icons.location_on_outlined),
                  ),
                ),
                Gap(15),
              ],
            ),
          );
        },
      ),
    );
  }
}
