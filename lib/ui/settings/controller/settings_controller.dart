import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/backend/base_responses/base_success_response.dart';
import 'package:get/get.dart';

import '../../../backend/api_end_points.dart';
import '../../../utils/base_functions.dart';
import '../../profile_tab/controller/profile_controller.dart';

class SettingsController extends GetxController{
  RxBool isNotificationEnable = true.obs;

  callApi({required bool newValue}){
    Map<String, String> data = {
      "is_send_notification": newValue ? "1" : "0",
    };
    BaseApiService().post(apiEndPoint: ApiEndPoints().enableNotifications, data: data, showLoader: false).then((value){
      if (value?.statusCode ==  200) {
        BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
        if (response.success??false) {
          // todo: Should be updated
          Get.find<ProfileController>().getProfileData();
        }else{
          showSnackBar(subtitle: response.message??"");
        }
      }else{
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }
}