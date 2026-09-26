import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/components/buttons/custom_button.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/dashboard/presentation/widgets/notes.dart';
import 'package:sihati/features/order/models/order_model.dart';
import 'package:sihati/features/order/models/rep_model.dart';
import 'package:sihati/features/order/presentation/cubit/buyer_state.dart';
import 'package:sihati/features/order/presentation/cubit/order_cubit.dart';
import 'package:sihati/features/order/presentation/cubit/person_cubit.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({
    super.key,
    this.name,
    this.loc,
    this.price,
    this.time,
    this.rep,
    this.ontap,
    required this.status,
    this.updaterep,
  });

  final String? name;
  final String? loc;
  final double? price;
  final String? time;
  final String? rep;
  final VoidCallback? ontap;
  final void Function(RepModel rep)? updaterep;
  final OrderStatus status;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  
  bool assign = false;
  @override
  Widget build(BuildContext context) {
    var cost = widget.price.toString();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 24,
              color: Colors.black.withValues(alpha: 0.1),
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(widget.name ?? "", style: Style.tab),
                Spacer(),
                if (widget.status == OrderStatus.onDelivering)
                  Notes(
                    text: "OnDelivering",
                    select: false,
                    color: Appcolors.splashup,
                  )
                else if (widget.status == OrderStatus.delivered)
                  Notes(text: "Done", select: false, color: Appcolors.slider)
                else
                  Notes(
                    text: "Pending",
                    select: false,
                    color: Appcolors.pending,
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppImages.map,
                  colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  width: 15,
                ),
                Gap(3),
                Text(widget.loc ?? "", style: TextStyle(color: Colors.grey)),
                Gap(2),
                Icon(Icons.circle, size: 2.4, color: Colors.grey),
                Gap(2),
                Text(widget.time ?? "", style: TextStyle(color: Colors.grey)),
              ],
            ),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    style: Style.loginFieldLabel.copyWith(
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(
                        text: "Cost".tr(),
                        style: Style.loginFieldLabel.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: " : ",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: cost,
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      const TextSpan(text: " "),
                      TextSpan(text: "EGP"),
                    ],
                  ),
                ),
              ],
            ),
            Gap(10),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: BlocBuilder<PersonCubit, PersonState>(
                builder: (context, state) {
                  var cubit = context.read<PersonCubit>();
                  return Column(
                    children: [
                      Gap(10),
                      if(widget.status == OrderStatus.pending)
                        assign == false
                            ? CustomButton(
                                onPressed: () {
                                  setState(() {
                                    assign = true;
                                  });
                                },
                                color1: Appcolors.l1,
                                color2: Appcolors.l2,
                                color3: Appcolors.l2,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person_2_outlined,
                                        color: Colors.white,
                                      ),
                                      Gap(5),
                                      Text(
                                        "Assign Rep For Delivery",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            :   Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Choose Rep :",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 100,
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 6,
                                            mainAxisSpacing: 3,
                                            crossAxisSpacing: 5,
                                          ),
                                      itemCount: cubit.repsList.length,
                                      itemBuilder: (context, index) {
                                        var rep = cubit.repsList[index];
                                        return GestureDetector(
                                          onTap: () {
                                            widget.updaterep?.call(rep);
                                          },
                                          child: Notes(
                                            text: rep.name,
                                            select: false,
                                            color: Appcolors.splashup,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(onPressed: (){setState(() {
                                        assign = false;
                                      });}, child: Text("cancle",))
                                    ],
                                  )
                                ],
                              )
                      else if (widget.status == OrderStatus.onDelivering)
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: Appcolors.login,
                              size: 12,
                            ),
                            Gap(5),
                            Text(
                              "Rep".tr(),
                              style: TextStyle(
                                color: Colors.black.withValues(alpha: .7),
                              ),
                            ),
                            Gap(5),
                            Text(":"),
                            Gap(5),
                            Text(widget.rep.toString()),
                            Spacer(),
                            GestureDetector(
                              //!update to delivered////////////////////////////////
                              onTap: widget.ontap,
                              child: Notes(
                                text: "تم تأكيد الإستلام".tr(),
                                select: true,
                                color: Appcolors.slider,
                              ),
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: Appcolors.login,
                              size: 12,
                            ),
                            Gap(5),
                            Text(
                              "Rep".tr(),
                              style: TextStyle(
                                color: Colors.black.withValues(alpha: .7),
                              ),
                            ),
                            Gap(5),
                            Text(":"),
                            Gap(5),
                            Text(widget.rep.toString()),
                          ],
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
