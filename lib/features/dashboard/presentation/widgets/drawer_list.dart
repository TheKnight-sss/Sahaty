import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sihati/core/routes/navigation.dart';
import 'package:sihati/core/routes/routes.dart';

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
    );
  }
}
