import 'package:flutter/material.dart';
import 'package:sihati/core/utils/product_color.dart';

class ProductOrderCard extends StatelessWidget {
  const ProductOrderCard({
    super.key,
    required this.productcolor,
    required this.productname,
    required this.edit,
    required this.quantityControllers,
    required this.productquantity,
    required this.productprice, required this.index,
  });

  final String? productcolor;
  final String? productname;
  final bool edit;
  final List<TextEditingController> quantityControllers;
  final double? productquantity;
  final double? productprice;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: getProductColor(
          productcolor,
        ).withValues(alpha: .4),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text("$productname")),
          edit == true
              ? Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 30,
                    child: TextField(
                      textAlign: TextAlign.center,
                      textAlignVertical:
                          TextAlignVertical.center,
                      cursorHeight: 16,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.0,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                        isDense: true,
                      ),
                      controller:
                          quantityControllers[index],
                    ),
                  ),
                )
              : Expanded(
                  flex: 2,
                  child: Text("$productquantity"),
                ),
          Expanded(
            flex: 2,
            child: Text(
              "${(productprice!) * (productquantity!)}",
            ),
          ),
        ],
      ),
    );
  }
}
