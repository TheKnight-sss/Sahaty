import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/products/presentation/widgets/head.dart';
import 'package:sihati/features/products/presentation/widgets/price.dart';

class ProductCardDetails extends StatelessWidget {
  const ProductCardDetails({
    super.key,
    required this.selectedUnit,
    this.onBoxTap,
    this.onKgTap, required this.productname, required this.quantity, required this.price,
  });

  final String selectedUnit;
  final VoidCallback? onBoxTap;
  final VoidCallback? onKgTap;
  final TextEditingController productname;
  final TextEditingController quantity;
  final TextEditingController price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
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
            'Product Details'.tr(),
            style: Style.loginFieldLabel.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          Gap(10),
          Head(head: 'Product Name'.tr()),
          Gap(10),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter product name'.tr(),
            ),
            controller: productname,
          ),
          Gap(20),
          Head(head: 'Quantity'.tr()),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 10,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter quantity'.tr(),
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: quantity,
                ),
              ),
              Container(
                height: 60,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: onKgTap,
                        child: Container(
                          height: 58,
                          decoration: BoxDecoration(
                            color: selectedUnit == 'kg'
                                ? Colors.blue
                                : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          child: Center(child: Text('kg'.tr())),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: onBoxTap,
                        child: Container(
                          height: 58,
                          decoration: BoxDecoration(
                            color: selectedUnit == 'box'
                                ? Colors.blue
                                : Colors.transparent,

                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Center(child: Text('box'.tr())),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(20),
          Price(selectedUnit: selectedUnit),
          Gap(10),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter price'.tr(),
            ),
            keyboardType: TextInputType.numberWithOptions(),
            controller: price,
          ),
        ],
      ),
    );
  }
}
