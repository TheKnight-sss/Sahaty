import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sihati/components/buttons/custom_button.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/order/presentation/cubit/buyer_cubit.dart';
import 'package:sihati/features/order/presentation/widgets/order_field.dart';

class AddorderAttributesScreen extends StatefulWidget {
  const AddorderAttributesScreen({super.key});

  @override
  State<AddorderAttributesScreen> createState() =>
      _AddorderAttributesScreenState();
}

class _AddorderAttributesScreenState extends State<AddorderAttributesScreen> {
  bool adding = false;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<BuyerCubit>();
    return Scaffold(
      appBar: AppBar(title: Text("Order Attributes"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Appcolors.slcard.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Buyer",
                        style: Style.loginFieldLabel.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            adding = !adding;
                          });
                        },
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: Appcolors.signinbg,
                        ),
                      ),
                    ],
                  ),
                  if (adding == true) ...[
                    Gap(10),
                    OrderField(
                      head: "Buyer",
                      hintText: 'Enter Buyer Name'.tr(),
                      prefixIcon: Icon(Icons.person_outline_sharp),
                      controller: cubit.buyerNameController,
                    ),
                    Gap(5),
                    OrderField(
                      head: "Location",
                      hintText: 'Enter Location'.tr(),
                      prefixIcon: Icon(Icons.person_outline_sharp),
                      controller: cubit.buyerNameController,
                    ),
                    Gap(5),
                    CustomButton(
                      onPressed: () {},
                      color1: Appcolors.splashup,
                      color2: Appcolors.splashcenter,
                      color3: Appcolors.splashdown,
                      child: Text("Add Buyer",style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
