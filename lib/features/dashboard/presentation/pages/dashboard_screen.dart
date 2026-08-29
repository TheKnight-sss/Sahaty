import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/dashboard/presentation/widgets/drawer_list.dart';
import 'package:sihati/features/dashboard/presentation/widgets/head_title.dart';
import 'package:sihati/features/dashboard/presentation/widgets/inventory_card.dart';
import 'package:sihati/features/dashboard/presentation/widgets/order_card.dart';
import 'package:sihati/features/dashboard/presentation/widgets/tab_button.dart';
import 'package:sihati/features/products/presentation/cubit/product_cubit.dart';
import 'package:sihati/features/products/presentation/cubit/product_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
    context.locale;
    print("Dashboard rebuilt: ${context.locale}");

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),

      drawer: Drawer(child: DrawerList()),

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: HeadTitle(),
      ),

      body: Column(
        children: [
          // =========================
          // INVENTORY / ORDERS TABS
          // =========================
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
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

                  bg: isSelected == "Inventory"
                      ? const Color(0xFF2563EB)
                      : const Color(0xFFF3F4F6),

                  fr: isSelected == "Inventory"
                      ? Colors.white
                      : const Color(0xFF6B7280),

                  elev: isSelected == "Inventory" ? 2 : 0,

                  onpressed: () {
                    setState(() {
                      isSelected = "Inventory";
                    });
                  },
                ),

                TabButton(
                  text: "Orders".tr(),

                  bg: isSelected == "Orders"
                      ? const Color(0xFF2563EB)
                      : const Color(0xFFF3F4F6),

                  fr: isSelected == "Orders"
                      ? Colors.white
                      : const Color(0xFF6B7280),

                  elev: isSelected == "Orders" ? 2 : 0,

                  onpressed: () {
                    setState(() {
                      isSelected = "Orders";
                    });
                  },
                ),
              ],
            ),
          ),

          const Gap(15),

          // =========================
          // INVENTORY STATE / ORDERS
          // =========================
          Container(
            padding: const EdgeInsets.all(8),

            child: Column(
              children: [
                isSelected == "Inventory"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          SvgPicture.asset(
                            AppImages.warehouse,

                            colorFilter: ColorFilter.mode(
                              Appcolors.splashup,
                              BlendMode.srcIn,
                            ),
                          ),

                          const Gap(5),

                          Text("Inventory State".tr(), style: Style.tab),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: Appcolors.splashup,
                          ),

                          const Gap(5),

                          Text("All Orders".tr(), style: Style.tab),
                        ],
                      ),

                const Gap(5),
              ],
            ),
          ),

          // =========================
          // ONLY PRODUCT AREA
          // =========================
          Expanded(
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductInitial) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ProductSuccess) {
                  final products = state.products;

                  return isSelected == "Inventory"
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),

                          child: ListView.separated(
                            itemCount: products.length,

                            separatorBuilder: (context, index) {
                              return const Gap(10);
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
                        )
                      : OrderCard();
                }

                if (state is ProductFailure) {
                  return const Center(child: Text("Something went wrong"));
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
