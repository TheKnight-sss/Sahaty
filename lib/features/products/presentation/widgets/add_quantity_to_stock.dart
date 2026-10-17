import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/routes/navigation.dart';
import 'package:sihati/core/routes/routes.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/products/presentation/cubit/product_cubit.dart';
import 'package:sihati/features/products/presentation/cubit/product_state.dart';

class AddQuantityToStock extends StatelessWidget {
  const AddQuantityToStock({
    super.key,
    required this.quantityController,
    this.onpressed,
    required this.productId, required this.unit,
  });
  final VoidCallback? onpressed;

  final TextEditingController quantityController;
  final String productId;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        } else if (state is ProductSuccess) {
          pushReplacementTo(context, Routes.dashboard);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Quantity added successfully".tr()),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .1),
              blurRadius: 1,
              offset: Offset(1, 3),
            ),
          ],
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Quantity To Stock".tr(),
                style: Style.subheader.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              Gap(10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter Quantity".tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: quantityController,
                    ),
                  ),
                  Gap(10),
                  Text(
                    unit,
                    style: Style.subheader.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  Gap(10),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolors.l1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        context.read<ProductCubit>().addToStock(
                          productId: productId,
                          quantity:
                              double.tryParse(quantityController.text) ?? 0,
                        );
                      },
                      child: Text(
                        "Add".tr(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
