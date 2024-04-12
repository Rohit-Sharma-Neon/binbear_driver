import 'dart:io';

import 'package:binbeardriver/backend/firebase_notification_service.dart';
import 'package:binbeardriver/backend/http_overrider.dart';
import 'package:binbeardriver/ui/base_components/base_text.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_localization.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:binbeardriver/ui/onboardings/splash/splash_screen.dart';

import 'ui/base_components/base_main_builder.dart';
void main() {
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
        pageTransitionsTheme: const PageTransitionsTheme(builders: {TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(), TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder()}),
      ),
      home: const SplashScreen(),
    );
  }
}


class CustomError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomError({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/error_illustration.png'),
            Text(
              kDebugMode
                  ? errorDetails.summary.toString()
                  : 'Oups! Something went wrong!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: kDebugMode ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21),
            ),
            const SizedBox(height: 12),
            const Text(
              kDebugMode
                  ? 'https://docs.flutter.dev/testing/errors'
                  : "We encountered an error and we've notified our engineering team about it. Sorry for the inconvenience caused.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
