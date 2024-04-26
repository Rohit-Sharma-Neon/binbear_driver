import 'dart:io';

import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/backend/base_responses/base_success_response.dart';
import 'package:binbeardriver/ui/change_password/change_password_screen.dart';
import 'package:binbeardriver/ui/onboardings/forgot_password/controller/forgot_password_controller.dart';
import 'package:binbeardriver/ui/onboardings/location/onboarding_location_screen.dart';
import 'package:binbeardriver/ui/onboardings/login/login_screen.dart';
import 'package:binbeardriver/ui/onboardings/otp_validation/model/otp_response.dart';
import 'package:binbeardriver/ui/onboardings/signup/controller/signup_controller.dart';
import 'package:binbeardriver/ui/onboardings/splash/controller/base_controller.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/get_storage.dart';
import 'package:binbeardriver/utils/storage_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  TextEditingController otpController = TextEditingController();
  RxBool isResendEnable = false.obs;

  callVerifyOtpApi() {
    Map<String, String> data = {
      "mobile_or_email": Get.find<SignUpController>().emailController.text.trim(),
      "verify_type": "email",
      "deviceType" : Platform.isAndroid ? "android" : "ios",
      "deviceId": "device_id",
      "role": "2",
      "country_code": "+1",
      "otp": otpController.text.trim(),
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().verifyOtp, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        OtpResponse response = OtpResponse.fromJson(value?.data);
        if (response.success ?? false) {
          BaseStorage.write(StorageKeys.apiToken, response.data?.token??"");
          // BaseStorage.write(StorageKeys.userName, response.data?.name??"");
          // BaseStorage.write(StorageKeys.profilePhoto, response.data?.profile??"");
          // BaseStorage.write(StorageKeys.isUserDriver, false);
          if (Get.find<BaseController>().isAddressTappedOnSignUp.value ==
              true) {
            Get.offAll(() => const LoginScreen());
            Get.to(() => OnboardingLocationScreen());
          } else {
            Get.offAll(() => const LoginScreen());
            showSnackBar(
                message: response.message ?? "",
                isSuccess: true,
                title: "Success");
          }
        } else {
          showSnackBar(message: response.message ?? "");
        }
      } else {
        showSnackBar(message: "Something went wrong, please try again");
      }
    });
  }

  forgotPasswordVerifyOtpApi() {
    Map<String, String> data = {
      "mobile_or_email":
          Get.find<ForgotPasswordController>().emailController.text,
      "verify_type": "email",
      "deviceType" : Platform.isAndroid ? "android" : "ios",
      "deviceId": "device_id",
      "role": (BaseStorage.read(StorageKeys.isUserDriver) ?? false) ? "3" : "2",
      "country_code": "+1",
      "otp": otpController.text.trim(),
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().verifyOtp, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        OtpResponse response = OtpResponse.fromJson(value?.data);
        if (response.success ?? false) {
          Get.back();
          Get.off(() => const ChangePasswordScreen(
                previousPage: "forgotPassword",
              ));
          showSnackBar(
              title: "Success!",
              message: response.message ?? "",
              isSuccess: true);
        } else {
          showSnackBar(message: response.message ?? "");
        }
      } else {
        showSnackBar(message: "Something went wrong, please try again");
      }
    });
  }

  Future<bool> resendOtp() async {
    bool returnValue = false;
    Map<String, String> data = {
      "email": Get.find<SignUpController>().emailController.text.trim(),
    };
    await BaseApiService().post(apiEndPoint: ApiEndPoints().resendOtp, data: data).then((value) {
      if (value?.statusCode == 200) {
        BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
        if (response.success ?? false) {
          returnValue = true;
          showSnackBar(message: response.message ?? "", isSuccess: true);
        } else {
          returnValue = false;
          showSnackBar(message: response.message ?? "");
        }
      } else {
        returnValue = false;
        showSnackBar(message: "Something went wrong, please try again");
      }
    });
    return returnValue;
  }
}
