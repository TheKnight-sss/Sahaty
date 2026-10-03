import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/dashboard/presentation/widgets/capacatiy.dart';
import 'package:sihati/features/order/presentation/cubit/order_cubit.dart';
import 'package:sihati/features/products/models/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool edit = false;

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
  Widget build(BuildContext context) {
    final orderCubit = context.read<OrderCubit>();

    final onDelivery = orderCubit.getProductOnDelivery(widget.product.name);
    final delivered = orderCubit.getProductDelivered(widget.product.name);

    final max = widget.product.maxquan ?? 0;

    final currentTotal = max - delivered;
    final remaining = currentTotal - onDelivery;

    final percentage = max > 0 ? currentTotal / max : 0;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(76),
        child: Container(
          decoration: BoxDecoration(
            color: Appcolors.l1,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(right: 5, left: 5, bottom: 10),
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                title: Text(
                  "Product Details",
                  style: Style.loginFieldLabel.copyWith(color: Colors.white),
                ),
                subtitle: Text(
                  "Product Details",
                  style: TextStyle(
                    color: Color(0xFFBFDBFE),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: InkWell(
                  onTap: () {
                    setState(() {
                      edit = !edit;
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .2),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.rotate(
                            angle: context.locale.languageCode == 'en'
                                ? 260 * 3.14 / 180
                                : 0,
                            child: Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          Gap(10),
                          Transform.translate(
                            offset: context.locale.languageCode == 'en'
                                ? Offset(-10, 0)
                                : Offset(10, 0),
                            child: Text(
                              edit ? "Edit".tr() : "View".tr(),
                              style: Style.subheader.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      //!Body///////////////////////////////////////////////////////////////////////////////////////
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: getProductColor(
                    widget.product.color,
                  ).withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        height: 100,
                        width: 60,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: .1),
                              blurRadius: 1,
                              offset: Offset(0, 3),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                        child: SvgPicture.asset(
                          fit: BoxFit.contain,
                          AppImages.logo,
                          colorFilter: ColorFilter.mode(
                            getProductColor(widget.product.color),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      title: Text(
                        "${widget.product.name}",
                        style: Style.loginSubTitle.copyWith(
                          color: getProductColor(widget.product.color),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Text("Remaining Quantity".tr()),
                          Text(" : $remaining ${(widget.product.unit)!.tr()}"),
                        ],
                      ),
                      trailing: SizedBox(
                        height: 30,
                        child: Capacatiy(
                          borderRadius: BorderRadius.circular(15),
                          percentage: percentage,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          LinearProgressIndicator(
                            minHeight: 8,
                            value: max > 0 ? currentTotal / max : 0,
                            backgroundColor: Colors.white,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              percentage >= .7
                                  ? Appcolors.slider
                                  : percentage >= .3
                                  ? Colors.orange
                                  : Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          const Gap(4),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '0',
                                style: Style.subheader.copyWith(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Remain'.tr(),
                                      style: Style.subheader.copyWith(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ' ${(currentTotal / max * 100).toStringAsFixed(0)}%',
                                      style: Style.subheader.copyWith(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '$max ${(widget.product.unit)!.tr()}',
                                style: Style.subheader.copyWith(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Gap(10),
                  ],
                ),
              ),
              Gap(20),
              Container(
                decoration: BoxDecoration(
                  boxShadow:[
                    BoxShadow(blurRadius: 5, color: Colors.black.withValues(alpha: .1), offset: Offset(0, 3))
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
