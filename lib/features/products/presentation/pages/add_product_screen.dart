import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/functions/dailog.dart';
import 'package:sihati/core/routes/navigation.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/products/presentation/cubit/product_cubit.dart';
import 'package:sihati/features/products/presentation/cubit/product_state.dart';
import 'package:sihati/features/products/presentation/widgets/add_product_button.dart';
import 'package:sihati/features/products/presentation/widgets/add_product_title.dart';
import 'package:sihati/features/products/presentation/widgets/color_item.dart';
import 'package:sihati/features/products/presentation/widgets/product_card_details.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String selectedUnit = 'kg';
  String? selectedcolor;
  final List<Map<String, dynamic>> colorOptions = [
    {'name': 'Green', 'color': Colors.green},
    {'name': 'Blue', 'color': Colors.blue},
    {'name': 'Orange', 'color': Colors.orange},
    {'name': 'Purple', 'color': Colors.purple},
    {'name': 'Pink', 'color': Colors.pink},
  ];
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProductCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff2563EB), Color(0xff1D4ED8)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: AddProductTitle(),
        ),
      ),
      body: BlocListener<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductInitial) {
            showLoadingDialog(context);
          } else if (state is ProductSuccess) {
            pop(context);
            showMyDialog(
              context,
              "Item Add Successfully",
              type: DialogType.success,
            );
          } else if (state is ProductFailure) {
            pop(context);
            showMyDialog(context, state.error, type: DialogType.error);
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: cubit.formkey,
                  child: Column(
                    children: [
                      ProductCardDetails(
                        productname: cubit.productnameController,
                        price: cubit.priceController,
                        quantity: cubit.quantityController,
                        selectedUnit: selectedUnit,
                        onBoxTap: () {
                          setState(() {
                            selectedUnit = 'box';
                          });
                        },
                        onKgTap: () {
                          setState(() {
                            selectedUnit = 'kg';
                          });
                        },
                      ),
                      Container(
                        height: 180,
                        padding: EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Color'.tr(),
                              style: Style.loginFieldLabel.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                            ),
                            Gap(20),
                            Container(
                              height: 90,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  final colorOption = colorOptions[index];
                                  final colorName =
                                      colorOption['name'] as String;
                                  final colorValue =
                                      colorOption['color'] as Color;
                                  return ColorItem(
                                    color: colorValue,
                                    isSelected: selectedcolor == colorName,
                                    colorName: colorName,
                                    onTap: () {
                                      setState(() {
                                        selectedcolor = colorName;
                                      });
                                    },
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Gap(10),
                                itemCount: colorOptions.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AddProductButton(
              onpressed: () {
                cubit.addProduct(
                  unit: selectedUnit,
                  color: selectedcolor ?? '',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
