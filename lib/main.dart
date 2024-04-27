import 'dart:io';

import 'package:binbeardriver/backend/firebase_notification_service.dart';
import 'package:binbeardriver/backend/http_overrider.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:binbeardriver/ui/onboardings/splash/splash_screen.dart';

import 'package:binbeardriver/ui/base_components/base_main_builder.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  runAppScaled(const MyApp(), scaleFactor: (deviceSize){
    const double widthOfDesign = 375;
    return deviceSize.width / widthOfDesign;
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    FirebaseNotificationService().initFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BinBear Driver',
      debugShowCheckedModeBanner: false,
      translations: BaseLocalization(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      builder: (BuildContext context, Widget? child) {
        return BaseMainBuilder(context: context, child: child);
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: BaseColors.primaryColor),
        primaryColor: BaseColors.primaryColor,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.transparent,
        fontFamily: 'NunitoSans',
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder()
        }),
      ),
      home: const SplashScreen(),
    );
  }
}