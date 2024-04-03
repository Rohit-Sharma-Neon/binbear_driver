import 'package:get/get.dart';

import '../../../backend/api_end_points.dart';
import '../../../backend/base_api_service.dart';
import '../../../utils/base_functions.dart';
import '../model/help_support_response.dart';

class HelpSupportController extends GetxController{
  RxList<HelpSupportData?>? list = <HelpSupportData?>[].obs;

  @override
  void onInit() {
    super.onInit();
    getResponse();
  }

  getResponse(){
    list?.clear();
    list?.refresh();
    BaseApiService().get(apiEndPoint: ApiEndPoints().helpSupport).then((value){
      if (value?.statusCode ==  200) {
        HelpSupportResponse response = HelpSupportResponse.fromJson(value?.data);
        if (response.success??false) {
          list?.value = response.data??[];
        }else{
          showSnackBar(message: response.message??"");
        }
      }else{
        showSnackBar(message: "Something went wrong, please try again");
      }
    });
  }
}