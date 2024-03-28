import 'package:animate_do/animate_do.dart';
import 'package:binbeardriver/ui/dashboard_module/dashboard_screen/dashboard_screen.dart';
import 'package:binbeardriver/ui/driver/jobs_screen/jobs_screen.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/get_storage.dart';
import 'package:binbeardriver/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../bookings_tab/controller/bookings_controller.dart';
import '../../dashboard_module/dashboard_screen/controller/dashboard_controller.dart';
import '../welcome_screen.dart';
import 'controller/base_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  BaseController baseController = Get.put(BaseController());
  DashboardController dashboardController = Get.put(DashboardController());
  BookingsController bookingsController = Get.put(BookingsController());

  bool showFooter = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initGetStorage();
      Future.delayed( const Duration(milliseconds: 2700), () async {
        setState(() {
          showFooter = false;
        });
      });
      Future.delayed( const Duration(seconds: 3), () async {
      if ((BaseStorage.read(StorageKeys.apiToken)??"").toString().isNotEmpty && BaseStorage.read(StorageKeys.isUserDriver) != null) {
        if (BaseStorage.read(StorageKeys.isUserDriver)) {
          Get.offAll(() => const JobsScreen());
        }else{
          Get.offAll(() => const DashBoardScreen());
        }
      }else{
        Get.offAll(() => const WelcomeScreen());
      }
    });
  });
  }

  initGetStorage() async {
    await GetStorage.init('MyStorage');
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
        child: Scaffold(
          body: Column(
            children: [
              const Spacer(flex: 2,),
              ZoomIn(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: Hero(
                    tag: "splash_tag",
                    child: SizedBox(
                      height: 260,
                      child: SvgPicture.asset(
                        BaseAssets.appLogoWithName,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
              ZoomIn(
                child: const BaseText(
                  value: "Welcome!\nBinbear Job Portal",
                  textAlign: TextAlign.center,
                  fontSize: 20,
                  color: Color(0xffFBE6D3),
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              FadeInUp(
                animate: showFooter,
                child: SvgPicture.asset(
                  BaseAssets.splashFooter,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
    );
  }
}
