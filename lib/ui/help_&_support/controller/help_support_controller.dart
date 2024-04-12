import 'package:get/get.dart';

import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/ui/help_&_support/model/help_support_response.dart';

class HelpSupportController extends GetxController{
  RxList<Faq?>? list = <Faq?>[].obs;
  HelpSupportData helpSupportData = HelpSupportData();


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
          list?.value = response.data?.faq??[];
          helpSupportData = response.data ?? HelpSupportData();
        }else{
          showSnackBar(message: response.message??"");
        }
      }else{
        showSnackBar(message: "Something went wrong, please try again");
      }
    });
  }
}