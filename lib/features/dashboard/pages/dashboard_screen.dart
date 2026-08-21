import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/functions/dailog.dart';
import 'package:sihati/core/functions/extension.dart';
import 'package:sihati/core/routes/navigation.dart';
import 'package:sihati/core/routes/routes.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/dashboard/widgets/detailed_tab.dart';
import 'package:sihati/features/dashboard/widgets/inventory_card.dart';
import 'package:sihati/features/dashboard/widgets/tab_button.dart';
import 'package:sihati/features/products/presentation/cubit/product_cubit.dart';
import 'package:sihati/features/products/presentation/cubit/product_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String inventory = "Inventory";
  String orders = "Orders";
  String isSelected = "Inventory";

  Color getProductColor(String? color) {
    switch (color) {
      case 'Green':
        return Colors.green;

      case 'Blue':
        return Colors.blue;

      case 'Orange':
        return Colors.orange;

      case 'Purple':
        return Colors.purple;

      case 'Pink':
        return Colors.pink;

      default:
        return Colors.grey;
    }
  }

  @override
  void initState() {
    super.initState();

    context.read<ProductCubit>().getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff2563EB), Color(0xff1D4ED8)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: null,
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'.tr()),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.add_circle_outline_sharp),

              title: Text('Add Product'.tr()),
              onTap: () {
                pushTo(context, Routes.addProduct);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'.tr()),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'.tr()),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff2563EB), Color(0xff1D4ED8)],
            ),

            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .2),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sahaty'.tr(), style: Style.header),
                  IconButton(
                    onPressed: () {
                      context.setLocale(
                        context.isArabic ? const Locale("en") : Locale("ar"),
                      );
                    },
                    icon: Icon(
                      Icons.language_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Gap(5),
              Text(
                "Inventory and Orders Dashboard".tr(),
                style: Style.subheader,
              ),
              Gap(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 10,
                children: [DetailedTab(), DetailedTab(), DetailedTab()],
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductSuccess) {
            final products = state.products;
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xFFF3F4F6)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    spacing: 10,
                    children: [
                      TabButton(
                        text: "Inventory".tr(),
                        bg: isSelected == inventory
                            ? Color(0xFF2563EB)
                            : Color(0xFFF3F4F6),
                        fr: isSelected == inventory
                            ? Colors.white
                            : Color(0xFF6B7280),
                        elev: isSelected == inventory ? 2 : 0,
                        onpressed: () {
                          setState(() {
                            isSelected = inventory;
                          });
                        },
                      ),
                      TabButton(
                        text: orders.tr(),
                        bg: isSelected == orders
                            ? Color(0xFF2563EB)
                            : Color(0xFFF3F4F6),
                        fr: isSelected == orders
                            ? Colors.white
                            : Color(0xFF6B7280),
                        elev: isSelected == orders ? 2 : 0,
                        onpressed: () {
                          setState(() {
                            isSelected = orders;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Gap(15),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            AppImages.warehouse,
                            colorFilter: ColorFilter.mode(
                              Appcolors.splashup,
                              BlendMode.srcIn,
                            ),
                          ),
                          Gap(5),
                          Text("Inventory State".tr(), style: Style.tab),
                        ],
                      ),
                      const Gap(5),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.separated(
                      itemCount: products.length,
                      separatorBuilder: (context, index) {
                        return Gap(10);
                      },
                      itemBuilder: (context, index) {
                        final product = products[index];

                        return InventoryCard(
                          color: getProductColor(product.color),
                          name: product.name ?? '',
                          remain: product.quantity ?? 0,
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else if (state is ProductFailure) {
            // pop(context);
            // showMyDialog(context, state.error, type: DialogType.error);
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox();
        },
      ),
    );
  }
}
