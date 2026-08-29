import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/dashboard/presentation/widgets/notes.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});


  @override
  Widget build(BuildContext context) {
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
                Text("El Asel", style: Style.tab),
                Spacer(),
                Notes(text:"Done",select: false,),
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
                Text("القاهرة", style: TextStyle(color: Colors.grey)),
                Gap(2),
                Icon(Icons.circle, size: 2.4, color: Colors.grey),
                Gap(2),
                Text("09:15", style: TextStyle(color: Colors.grey)),
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
                      const TextSpan(text: " : ",style: TextStyle(fontWeight: FontWeight.w400)),
                      const TextSpan(text: "6,000",style: TextStyle(fontWeight: FontWeight.w400)),
                      const TextSpan(text: " "),
                      TextSpan(text: "EGP")
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
              child: Column(
                children: [
                  Gap(10),
                  Row(
                    children: [
                      Icon(Icons.circle,color: Appcolors.login,size: 12,),
                      Gap(5),
                      Text("Rep".tr(),style: TextStyle(color: Colors.black.withValues(alpha: .7)),),
                      Gap(5),
                      Text(":"),
                      Gap(5),
                      Text("محمد أحمد"),
                      Spacer(),
                      Notes(text:"تم تأكيد الإستلام".tr(),select: true,)

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
