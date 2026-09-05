import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/style.dart';

class OrderItemCard extends StatefulWidget {
   const OrderItemCard({
    super.key, required this.orderproductname, this.orderproductprice, this.orderproductquantity, this.orderproductunit,
  });
  final String orderproductname;
  final double? orderproductprice;
  final double? orderproductquantity;
  final String? orderproductunit;

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  late final TextEditingController orderproductquantitycontroller;
  final colors = {
      'Green': Colors.green,
      'Blue': Colors.blue,
      'Orange': Colors.orange,
      'Purple': Colors.purple,
      'Pink': Colors.pink,
    };

     @override
  void initState() {
    super.initState();

    orderproductquantitycontroller = TextEditingController(
      text: widget.orderproductquantity?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    orderproductquantitycontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppImages.logo,
                width: 40,
                height: 40,
                colorFilter: ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.orderproductname,
                  style: Style.loginFieldLabel.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Price: ${(widget.orderproductprice??0)*(widget.orderproductquantity??0)}",
                  style: Style.loginFieldLabel.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),                    
              ],
            ),
          ),
          Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Quantity",
                        style: Style.loginFieldLabel.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    SizedBox(
                      width: 100,
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: (widget.orderproductquantity?.toString() ?? 'Enter quantity'),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                        ),
                        controller: orderproductquantitycontroller,
                        keyboardType: TextInputType.number,
                      ),
                    ),                       
                  ],
                ),
                Gap(10),
           Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
             child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                      ),
                    ),
           ),
        ],
      ),
    );
  }
}
