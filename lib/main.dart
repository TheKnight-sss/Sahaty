import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sihati/core/routes/routes.dart';
import 'package:sihati/core/services/local/shared_pref.dart';
import 'package:sihati/core/utils/themes.dart';
import 'package:sihati/features/auth/presentation/cubit/authcubit.dart';
import 'package:sihati/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await SharedPref.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`

  runApp(
    EasyLocalization(
      supportedLocales: [const Locale('en'), const Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => AuthCubit())],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routes.route,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
    );
  }
}
