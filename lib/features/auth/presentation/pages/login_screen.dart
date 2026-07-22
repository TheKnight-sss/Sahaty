import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/functions/dailog.dart';
import 'package:sihati/core/routes/navigation.dart';
import 'package:sihati/core/routes/routes.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/auth/models/user_type_enum.dart';
import 'package:sihati/features/auth/presentation/cubit/authcubit.dart';
import 'package:sihati/features/auth/presentation/cubit/authstate.dart';
import 'package:sihati/features/auth/presentation/widgets/login_card.dart';
import 'package:sihati/features/auth/presentation/widgets/logo.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key, this.role});

  final UserTypeEnum? role;
  final _formKey = GlobalKey<FormState>();
  UserTypeEnum? user;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Scaffold(
      backgroundColor: Appcolors.login,
      body: BlocListener<AuthCubit, Authstate>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showLoadingDialog(context);
          }
          if (state is AuthSuccess) {
            Navigator.pop(context);
            if (state.role == UserTypeEnum.admin) {
              pushTo(context, Routes.dashboard);
            }
            if (state.role == UserTypeEnum.coRep) {}
          }
          if (state is AuthFailure) {
            Navigator.pop(context);
            showMyDialog(context, state.errorMessage, type: DialogType.error);
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(20),
                Logo(logoColor: Appcolors.login),
                Gap(20),
                Text("صحتي", style: Style.splashTitle),
                Gap(50),
                LoginCard(
                  rememberMe: rememberMe,
                  onPressed: () {
                    if (widget._formKey.currentState!.validate()) {
                      cubit.login();
                    }
                  },
                  emailController: cubit.emailController,
                  passwordController: cubit.passwordController,
                  formKey: widget._formKey,
                ),
                Gap(15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.user = UserTypeEnum.admin;
                          });
                        },
                        child: const Text("Admin"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.user = UserTypeEnum.coRep;
                          });
                        },
                        child: const Text("CoRep"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
