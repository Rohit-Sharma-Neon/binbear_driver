import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/ui/dashboard_module/dashboard_screen/dashboard_screen.dart';
import 'package:binbeardriver/ui/driver/jobs_screen/jobs_screen.dart';
import 'package:binbeardriver/ui/onboardings/location/onboarding_location_screen.dart';
import 'package:binbeardriver/ui/onboardings/login/model/login_response.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/get_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/storage_keys.dart';

class LoginController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString selectedUserType = "Service Provider".obs;
  bool obscurePassword = true;

  @override
  void onInit() {
    BaseStorage.write(StorageKeys.isUserDriver, false);
    super.onInit();
  }

  getResponse(){
    Map<String, String> data = {
      "email":emailController.text.trim(),
      "password":passwordController.text.trim(),
      "device_token":"xxxxxxxx",
      "role_id": BaseStorage.read(StorageKeys.isUserDriver) ? "3" : "2",
    };
    BaseApiService().post(apiEndPoint: ApiEndPoints().login, data: data).then((value){
      if (value?.statusCode ==  200) {
        LoginResponse response = LoginResponse.fromJson(value?.data);
        if (response.success??false) {
          BaseStorage.write(StorageKeys.apiToken, response.data?.token??"");
          BaseStorage.write(StorageKeys.userName, response.data?.name??"");
          BaseStorage.write(StorageKeys.profilePhoto, response.data?.profile??"");
          if(response.data?.hasAddress.toString() == "false" ) {
            Get.to(() => OnboardingLocationScreen());
          }else{
             if (BaseStorage.read(StorageKeys.isUserDriver)) {  
              Get.offAll(() => const JobsScreen());
            } else {
              Get.offAll(() => const DashBoardScreen());
            }
          }

         
        }else{
          showSnackBar(subtitle: response.message??"");
        }
      }else{
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }
}