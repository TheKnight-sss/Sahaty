import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sihati/components/buttons/custom_button.dart';
import 'package:sihati/components/inputs/custom_email_textfield.dart';
import 'package:sihati/components/inputs/password_custom_field.dart';
import 'package:sihati/core/functions/dailog.dart';
import 'package:sihati/core/routes/navigation.dart';
import 'package:sihati/core/routes/routes.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/auth/models/user_type_enum.dart';
import 'package:sihati/features/auth/presentation/cubit/authcubit.dart';
import 'package:sihati/features/auth/presentation/cubit/authstate.dart';
import 'package:sihati/features/auth/presentation/widgets/logo.dart';

// ignore: must_be_immutable
class SigninScreen extends StatefulWidget {
  SigninScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
    UserTypeEnum selecteduser = UserTypeEnum.coRep;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, Authstate>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showLoadingDialog(context);
        }
        if (state is AuthSuccess) {
          Navigator.pop(context);
          showMyDialog(
            context,
            "تم إنشاء الحساب بنجاح",
            type: DialogType.success,
          );
          if (selecteduser == UserTypeEnum.admin) {
            goToBase(context, Routes.login);
          } else {
            goToBase(context, Routes.login);
          }
        }
        if (state is AuthFailure) {
          Navigator.pop(context);
          showMyDialog(context, state.errorMessage, type: DialogType.error);
        }
      },

      child: Scaffold(
        body: Form(
          key: widget._formKey,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF16A34A),
                  Color(0xFF15803D),
                  Color(0xFF166534),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(70),
                  Logo(logoColor: Appcolors.signinbg),
                  Gap(20),
                  Text("صحتي", style: Style.splashTitle),
                  Gap(5),
                  Text(
                    "إنشاء حساب جديد",
                    style: Style.splashTitle.copyWith(fontSize: 14),
                  ),
                  Container(
                    padding: EdgeInsets.all(24),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          spreadRadius: 3,
                          color: Colors.black.withValues(alpha: 0.2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text("تسجيل", style: Style.loginSubTitle),
                        ),
                        Gap(20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "الاسم الكامل ",
                            style: Style.loginFieldLabel,
                          ),
                        ),
                        Gap(5),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "أدخل الأسم";
                            }
                            return null;
                          },
                          controller: cubit.nameController,
                          decoration: InputDecoration(
                            hintText: "أحمد محمد",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Gap(10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "البريد الإلكتروني ",
                            style: Style.loginFieldLabel,
                          ),
                        ),
                        Gap(5),
                        CustomEmailTextfield(
                          hint: "example@Shatay.com",
                          controller: cubit.emailController,
                          val: "برجاء إدخال البريد",
                        ),
                        Gap(10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "رقم الهاتف ",
                            style: Style.loginFieldLabel,
                          ),
                        ),
                        Gap(5),
                        TextFormField(
                          controller: cubit.phoneController,
                          decoration: InputDecoration(
                            hintText: "0123456789",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "برجاء إدخال رقم الهاتف";
                            }
                            return null;
                          },
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Gap(10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "كلمة المرور ",
                            style: Style.loginFieldLabel,
                          ),
                        ),
                        Gap(5),
                        PasswordCustomField(
                          controller: cubit.passwordController,
                          val: "برجاء إدخال الرقم السري",
                        ),
                        Gap(10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "تأكيد كلمة المرور ",
                            style: Style.loginFieldLabel,
                          ),
                        ),
                        Gap(5),
                        PasswordCustomField(
                          controller: cubit.passwordController,
                        ),
                        Gap(10),
                        CustomButton(
                          onPressed: () {
                            setState(() {
                             selecteduser = UserTypeEnum.admin;
                            });
                          },                          
                          color1: selecteduser == UserTypeEnum.admin?  Color(0xFF16A34A) : Color(0xFF166534) ,
                          color2: selecteduser == UserTypeEnum.admin? Color(0xFF15803D) :  Color(0xFF166534),
                          color3: selecteduser == UserTypeEnum.admin? Color(0xFF166534):  Color(0xFF166534),
                          child: Text(
                            "Admin",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        Gap(20),
                        CustomButton(
                          color1: Color(0xFF16A34A),
                          color2: Color(0xFF15803D),
                          color3: Color(0xFF166534),
                          child: Text(
                            "إنشاء حساب",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          onPressed: () {
                              debugPrint("selecteduser = $selecteduser");
                            if (widget._formKey.currentState!.validate()) {
                              cubit.register(type: selecteduser);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
