import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base_components/animated_column.dart';
import '../../base_components/base_app_bar.dart';
import '../../base_components/base_button.dart';
import '../../base_components/base_container.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../manual_address/manual_address_screen.dart';
import '../splash/controller/base_controller.dart';
import 'controller/onboarding_location_controller.dart';

class OnboardingLocationScreen extends StatelessWidget {
  OnboardingLocationScreen({super.key});

  final OnBoardingLocationController controller = Get.put(OnBoardingLocationController());
  final BaseController baseController = Get.find<BaseController>();

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        appBar: const BaseAppBar(),
        body: SingleChildScrollView(
          child: AnimatedColumn(
            children: [
              BaseContainer(
                topPadding: 20,
                child: AnimatedColumn(
                  children: [
                    Image.asset(
                      BaseAssets.icLocation,
                      width: 210,
                      height: 210,
                      fit: BoxFit.fitHeight,
                    ),
                    const BaseText(
                      value: "Address",
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    const BaseText(
                      topMargin: 10,
                      value: "Please allow us to fetch your\nlocation, or you can add your\nlocation manually.",
                      fontSize: 15,
                      textAlign: TextAlign.center,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    BaseButton(
                      topMargin: 35,
                      title: "Enable Location",
                      btnColor: BaseColors.secondaryColor,
                      onPressed: (){
                        baseController.getCurrentLocation();
                      },
                    ),
                    BaseButton(
                      topMargin: 18,
                      title: "Add Location Manually",
                      onPressed: (){
                        Get.to(() => const ManualAddressScreen());
                      },
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
