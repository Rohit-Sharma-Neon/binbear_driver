import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../map_view/map_view_screen.dart';
import '../../onboardings/splash/controller/base_controller.dart';

class ManualAddressController extends GetxController{
  TextEditingController searchController = TextEditingController();

  locateToCurrentLocation() async {
    await Get.find<BaseController>().getCurrentLocation().then((value) {
      if (value?.latitude != null && value?.longitude != null) {
        Get.to(()=> MapViewScreen(lat: value?.latitude??0, long: value?.longitude??0));
      }
    });
  }
}