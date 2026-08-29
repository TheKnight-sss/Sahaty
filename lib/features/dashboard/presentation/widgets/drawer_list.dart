import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/routes/navigation.dart';
import 'package:sihati/core/routes/routes.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';

class DrawerList extends StatelessWidget {
  const DrawerList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                    begin: Alignment.topCenter,

                    end: Alignment.bottomCenter,
                    colors: [
                      Appcolors.splashup,
                      Appcolors.splashdown,
                    ],
                  ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 45,
                          height: 45,
                          child: SvgPicture.asset(
                            AppImages.logo,
                            colorFilter: ColorFilter.mode(
                              Appcolors.splashup,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(10),
                    Text("Sahaty".tr(),style: Style.header.copyWith(fontSize: 25),)
            ],
          ),
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
          title: Text("Add Order".tr()),
          onTap: () {
            pushTo(context, Routes.addorder);
          },
          leading:Icon(Icons.add_circle_outline_sharp) ,
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
    );
  }
}
