import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sihati/components/buttons/custom_button.dart';
import 'package:sihati/components/inputs/custom_email_textfield.dart';
import 'package:sihati/components/inputs/password_custom_field.dart';
import 'package:sihati/core/routes/navigation.dart';
import 'package:sihati/core/routes/routes.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({
    super.key,
    required this.rememberMe,
    required this.onPressed,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
  }) : _formKey = formKey;

  final bool rememberMe;
  final VoidCallback onPressed;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> _formKey;

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 22, right: 22, bottom: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Form(
        key: widget._formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("تسجيل الدخول", style: Style.loginSubTitle),
            Gap(20),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: Text("البريد الالكتروني", style: Style.loginFieldLabel),
            ),
            Gap(5),
            CustomEmailTextfield(
              hint: "example@Shatay.com",
              controller: widget.emailController,
            ),
            Gap(10),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: Text("كلمة المرور", style: Style.loginFieldLabel),
            ),
            Gap(5),
            PasswordCustomField(controller: widget.passwordController),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "نسيت كلمة المرور؟",
                    style: TextStyle(color: Appcolors.login, fontSize: 16),
                  ),
                ),
                Spacer(),
                Text("تذكرني", style: Style.loginFieldLabel),
                // Checkbox(
                //   value: widget.rememberMe,
                //   activeColor: Appcolors.login,
                //   onChanged: (value) {
                //     setState(() {
                //       widget.rememberMe;
                //     });
                //   },
                // ),
              ],
            ),
            Gap(20),
            CustomButton(
              color1: Appcolors.l1,
              color2: Appcolors.l2,
              color3: Appcolors.l3,
              onPressed: widget.onPressed,
              child: Text(
                "تسجيل الدخول",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    pushReplacementTo(context, Routes.register);
                  },
                  child: Text(
                    "انشاء حساب",
                    style: TextStyle(color: Appcolors.login, fontSize: 16),
                  ),
                ),
                Text("ليس لديك حساب؟", style: Style.loginFieldLabel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
