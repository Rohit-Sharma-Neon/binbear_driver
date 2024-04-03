import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/ui/onboardings/base_success_screen.dart';
import 'package:binbeardriver/ui/onboardings/login/login_screen.dart';
import 'package:binbeardriver/ui/onboardings/otp_validation/model/otp_response.dart';
import 'package:binbeardriver/ui/onboardings/signup/controller/signup_controller.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/get_storage.dart';
import 'package:binbeardriver/utils/storage_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OtpController extends GetxController{
  TextEditingController otpController = TextEditingController();
  RxBool isResendEnable = false.obs;

  callVerifyOtpApi(){
    Map<String, String> data = {
      "mobile_or_email":Get.find<SignUpController>().mobileController.text.trim().replaceAll("(", "").replaceAll(")", "").replaceAll("-", "").replaceAll(" ", ""),
      "verify_type":"mobile",
      "deviceType":"android",
      "deviceId":"device_id",
      "role":"2",
      "country_code":"+1",
      "otp":otpController.text.trim(),
    };
    BaseApiService().post(apiEndPoint: ApiEndPoints().verifyOtp, data: data).then((value){
      if (value?.statusCode ==  200) {
        OtpResponse response = OtpResponse.fromJson(value?.data);
        if (response.success??false) {
          // BaseStorage.write(StorageKeys.apiToken, response.data?.token??"");
          // BaseStorage.write(StorageKeys.userName, response.data?.name??"");
          // BaseStorage.write(StorageKeys.profilePhoto, response.data?.profile??"");
          // BaseStorage.write(StorageKeys.isUserDriver, false);
          Get.offAll(() => const LoginScreen());
            showSnackBar(
              message: response.message ?? "",
              isSuccess: true,
              title: "Success");
        }else{
          showSnackBar(message: response.message??"");
        }
      }else{
        showSnackBar(message: "Something went wrong, please try again");
      }
    });
  }
}