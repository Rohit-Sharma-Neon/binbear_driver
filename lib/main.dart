import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scaled_app/scaled_app.dart';
import 'ui/onboardings/splash/splash_screen.dart';
void main() {
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
    Future.microtask(() async {
      await GetStorage.init();
    });
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
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!
        );
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: BaseColors.primaryColor),
        primaryColor: BaseColors.primaryColor,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.transparent,
        fontFamily: 'NunitoSans',
        pageTransitionsTheme: const PageTransitionsTheme(builders: {TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()}),
      ),
      home: const SplashScreen(),
    );
  }
}
