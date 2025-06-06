import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/ui/about_app/model/about_app_response.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:get/get.dart';

class AboutAppController extends GetxController{
  RxString title = "".obs;
  RxString description = "".obs;

  getResponse({required String type}){
    String apiEndPoint;
    if (type == "Privacy Policy") {
      apiEndPoint = ApiEndPoints().privacyPolicies;
    }else if (type == "Terms & Conditions") {
      apiEndPoint = ApiEndPoints().termsAndConditions;
    }else{
      apiEndPoint = ApiEndPoints().aboutUs;
    }
    BaseApiService().get(apiEndPoint: apiEndPoint).then((value){
      if (value?.statusCode ==  200) {
        AboutAppResponse response = AboutAppResponse.fromJson(value?.data);
        if (response.success??false) {
          title.value = response.data?.first.title??"";
          description.value = response.data?.first.description??"";
        }else{
          showSnackBar(message: response.message??"");
        }
      }else{
        showSnackBar(message: "Something went wrong, please try again");
      }
    });
  }
}