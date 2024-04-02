import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../backend/api_end_points.dart';
import '../../../backend/base_api_service.dart';
import '../../../backend/base_responses/base_success_response.dart';
import '../../../utils/base_functions.dart';
import '../../about_app/model/about_app_response.dart';
import '../model/driverlist_response.dart';

class HomeTabController extends GetxController {

  List<LatLng> testingLatLngList = [
    const LatLng(26.854388241227724, 75.76720853834199),
    const LatLng(26.85793580484039, 75.79552164216459),
    const LatLng(26.839403843470524, 75.78264703981174),
    const LatLng(26.830213316001327, 75.80556383199985),
    const LatLng(26.849257634454656, 75.765309534498),
    const LatLng(26.854388241227724, 75.76720853834199),
    const LatLng(26.85793580484039, 75.79552164216459),
    const LatLng(26.839403843470524, 75.78264703981174),
    const LatLng(26.830213316001327, 75.80556383199985),
    const LatLng(26.849257634454656, 75.765309534498),
  ];

  RxInt selectedDriverIndex = 0.obs;
  RxList<DriverData>? listDriver = <DriverData>[].obs;
  RefreshController refreshController = RefreshController(
      initialRefresh: false);

  driverList() {
    try {
      BaseApiService().post(
          apiEndPoint: ApiEndPoints().driverList).then((value) {
        if (value?.statusCode == 200) {
          DriverList response = DriverList.fromJson(value?.data);
          if (response.success ?? false) {
            listDriver?.value = response.data ?? [];
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } else {
          showSnackBar(subtitle: "Something went wrong, please try again");
        }
      });
    } on Exception catch (e) {
      refreshController.refreshCompleted();
    }
  }

  deleteDriver(dynamic id ,int index){
    Map<String, dynamic> params = {'binbear_id': id};

    BaseApiService().post(apiEndPoint: ApiEndPoints().driverDelete,data: params).then((value){
      if (value?.statusCode ==  200) {
        BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
        if (response.success??false) {
          triggerHapticFeedback();
          showSnackBar(subtitle: response.message??"", isSuccess: true);
          listDriver?.removeAt(index);
        }else{
          showSnackBar(subtitle: response.message??"");
        }
      }else{
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }
}