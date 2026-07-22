import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/routes/navigation.dart';
import 'package:sihati/core/routes/routes.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/auth/models/user_type_enum.dart';
import 'package:sihati/features/auth/presentation/cubit/authcubit.dart';
import 'package:sihati/features/auth/presentation/cubit/authstate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    Future.delayed(const Duration(seconds: 3), () {
      if (user != null) {
        if (user.photoURL == "admin") {
          pushTo(context, Routes.dashboard);
          
        }
      } else {
        pushReplacementTo(context, Routes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocListener<AuthCubit, Authstate>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            if (state.role == UserTypeEnum.admin) {
              pushReplacementTo(context, Routes.dashboard);
            } else {
              pushReplacementTo(context, Routes.dashboard);
            }
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,

                    end: Alignment.bottomCenter,
                    colors: [
                      Appcolors.splashup,
                      Appcolors.splashcenter,
                      Appcolors.splashdown,
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -75,
                left: -90,
                child: Container(
                  height: 192,
                  width: 192,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
              ),
              Positioned(
                bottom: -75,
                right: -90,
                child: Container(
                  height: 256,
                  width: 256,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 112,
                      width: 112,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 56,
                          height: 56,
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
                    Gap(20),
                    Text("صحتي", style: Style.splashTitle),
                    Gap(15),
                    Text(
                      "SAHATY",
                      style: Style.splashTitle.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
