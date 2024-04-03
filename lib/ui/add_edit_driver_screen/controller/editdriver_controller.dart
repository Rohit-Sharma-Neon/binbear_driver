import 'package:binbeardriver/ui/onboardings/splash/controller/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../backend/api_end_points.dart';
import '../../../backend/base_api_service.dart';
import '../../../backend/base_responses/base_success_response.dart';
import '../../../utils/base_functions.dart';

class EditDriverController extends GetxController{

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  editDriver(String id){
    Map<String, String> data = {
      "binbear_id":id,
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
    };
    BaseApiService().post(apiEndPoint: ApiEndPoints().editDriver, data: data).then((value){
      if (value?.statusCode ==  200) {
        BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
        if (response.success??false) {
          triggerHapticFeedback();
          Get.back();
          showSnackBar(message: response.message??"", isSuccess: true);
        }else{
          showSnackBar(message: response.message??"");
        }
      }else{
        showSnackBar(message: "Something went wrong, please try again");
      }
    });
  }

  addDriver(){
    Map<String, String> data = {
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "device_token":'',
    };
    BaseApiService().post(apiEndPoint: ApiEndPoints().addDriver, data: data).then((value){
      if (value?.statusCode ==  200) {
        BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
        if (response.success??false) {
          triggerHapticFeedback();
          Get.back();
          showSnackBar(message: response.message??"", isSuccess: true);
          Get.find<BaseController>().driverList();
        }else{
          showSnackBar(message: response.message??"");
        }
      }else{
        showSnackBar(message: "Something went wrong, please try again");
      }
    });
  }
}