import 'dart:async';

import 'package:binbeardriver/ui/onboardings/base_success_screen.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:binbeardriver/ui/base_components/base_text.dart';

class ServiceProviderMapViewController extends GetxController{
  RxString currentWorkStatus = "Pick-Up!".obs;
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  @override
  void onInit() {
    currentWorkStatus.value = "Pick-Up!";
    super.onInit();
  }

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(26.8506252, 75.7616548),
    zoom: 14.4746,
  );

  Widget getButtonContent(){
    switch (currentWorkStatus.value) {
      case "Pick-Up!": {
        return const BaseText(
          value: "Pick-Up!",
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        );
      }
      case "On The Way": {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(BaseAssets.icOnTheWay),
            const BaseText(
              value: "On The Way",
              fontSize: 14,
              leftMargin: 9,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ],
        );
      }
      case "Deliver Back To Home": {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(BaseAssets.icDeliverBackToHome),
            const BaseText(
              value: "Deliver Back To Home",
              fontSize: 14,
              leftMargin: 9,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ],
        );
      }
      case "Completed": {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(BaseAssets.icCompleted),
            const BaseText(
              value: "Completed",
              fontSize: 14,
              leftMargin: 9,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ],
        );
      }
      default: {
        return const BaseText(
          value: "Pick-Up!",
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        );
      }
    }
  }

  void onButtonTap(){
    switch (currentWorkStatus.value) {
      case "Pick-Up!": {
        currentWorkStatus.value = "On The Way";
        break;
      }
      case "On The Way": {
        currentWorkStatus.value = "Deliver Back To Home";
        break;
      }
      case "Deliver Back To Home": {
        currentWorkStatus.value = "Completed";
        break;
      }
      case "Completed": {
        Get.off(() => BaseSuccessScreen(
          title: "Completed",
          description: "Please continue on to your next\nstop and remember to ALWAYS\ndrive safe!",
          btnTitle: "OK",
          onBtnTap: (){
            Get.back();
          },
        ));
        break;
      }
      default: {
        currentWorkStatus.value = "Pick-Up!";
        break;
      }
    }
  }
}