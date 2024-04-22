import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/backend/base_responses/base_success_response.dart';
import 'package:binbeardriver/ui/dashboard_module/dashboard_screen/dashboard_screen.dart';
import 'package:binbeardriver/ui/driver/jobs_screen/jobs_screen.dart';
import 'package:binbeardriver/ui/onboardings/base_success_screen.dart';
import 'package:binbeardriver/ui/onboardings/splash/controller/base_controller.dart';
import 'package:binbeardriver/ui/onboardings/welcome_screen.dart';
import 'package:binbeardriver/ui/profile_tab/controller/profile_controller.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/get_storage.dart';
import 'package:binbeardriver/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageAddressController extends GetxController {
  RxString selectedAddressType = "Home".obs;
  TextEditingController houseNoController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  List<String> addressTypeList = [
    "Home",
    "Work",
    "Friends & Family",
    "Other",
  ];

  saveAddress({required double lat, required double lng, required String fullAddress, bool? showSavedAddress, String? addressId}) {
    Map<String, String> data = {
      "flat_no": houseNoController.text.trim(),
      "apartment": apartmentController.text.trim(),
      "description": landmarkController.text.trim(),
      "home_type": "2", // default type is "2" defined by backend
      "full_address": fullAddress,
      "lat": lat.toString(),
      "lng": lng.toString(),
    };
    if((addressId??"").isNotEmpty){
      data["address_id"] = addressId??"";
    }
    BaseApiService().post(apiEndPoint: ApiEndPoints().addAddress, data: data).then((value) async {
      if (value?.statusCode == 200) {
        BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
        if (response.success ?? false) {
          if (showSavedAddress ?? false) {
            Get.back();
            Get.back();
            Get.find<BaseController>().getSavedAddress();
          }
          else {
            if (BaseStorage.read(StorageKeys.isUserDriver)??false) {
              Get.offAll(() => const JobsScreen());
            } else {
              if (Get.find<BaseController>().isAddressTappedOnSignUp.value == true) {
                Get.to(BaseSuccessScreen(
                  btnTitle: "Login",
                  onBtnTap: () {
                    Get.offAll(const WelcomeScreen());
                  },
                ));
              } else {
                if ((addressId??"").isEmpty) {
                  Get.offAll(() => const DashBoardScreen());
                }else{
                  await Get.find<ProfileController>().getProfileData(showLoader: true);
                  Get.find<ProfileController>().update();
                  Get.back();
                }
              }
            }
            // Get.offAll(() => const DashBoardScreen());
          }
        } else {
          showSnackBar(message: response.message ?? "");
        }
      } else {
        showSnackBar(message: "Something went wrong, please try again");
      }
    });
  }

  updateAddress(
      {required double lat,
        required double lng,
        required String fullAddress,
        required String savedAddressId}) {
    Map<String, String> data = {
      "flat_no": houseNoController.text.trim(),
      "apartment": apartmentController.text.trim(),
      "description": landmarkController.text.trim(),
      "home_type": "2", // default type is "2" defined by backend
      "full_address": fullAddress,
      "lat": lat.toString(),
      "lng": lng.toString(),
      "address_id": savedAddressId,
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().addAddress, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        BaseSuccessResponse response =
        BaseSuccessResponse.fromJson(value?.data);
        if (response.success ?? false) {
          Get.offAll(() => const DashBoardScreen());
        } else {
          showSnackBar(message: response.message ?? "");
        }
      } else {
        showSnackBar(message: "Something went wrong, please try again");
      }
    });
  }
}
