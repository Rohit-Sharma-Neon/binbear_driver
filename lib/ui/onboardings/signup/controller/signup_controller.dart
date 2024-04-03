import 'dart:io';

import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/backend/base_responses/base_success_response.dart';
import 'package:binbeardriver/ui/onboardings/otp_validation/otp_screen.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  TextEditingController nameController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  File? pickedFile = File("");


  callSignUpApi() async {
    dio.FormData data = dio.FormData.fromMap({
      "name":nameController.text.trim(),
      "business_name":businessNameController.text.trim(),
      "email":emailController.text.trim(),
      "country_code":"+1",
      "mobile_no":mobileController.text.trim().replaceAll("(", "").replaceAll(")", "").replaceAll("-", "").replaceAll(" ", ""),
      "role_id": "2",
      "role": "2",
      "password":passwordController.text.trim(),
      "confirm_password":confirmPasswordController.text.trim(),
      "device_token":"xx",
    });
    if ((pickedFile?.path??"").isNotEmpty) {
      data.files.add(MapEntry("id_proof", await dio.MultipartFile.fromFile((pickedFile?.path??""))));
    }
    BaseApiService().post(apiEndPoint: ApiEndPoints().signUpEndPoint, data: data).then((value){
      if (value?.statusCode ==  200) {
        BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
        if (response.success??false) {
          Get.to(()=> const OtpScreen());
        }else{
          showSnackBar(message: response.message??"");
        }
      }else{
        showSnackBar(message: "Something went wrong, please try again");
      }
    });
  }
}