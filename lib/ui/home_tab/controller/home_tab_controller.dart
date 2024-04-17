import 'dart:developer';

import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/backend/base_responses/base_success_response.dart';
import 'package:binbeardriver/ui/home_tab/model/home_data_response.dart';
import 'package:binbeardriver/ui/onboardings/splash/controller/base_controller.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  List<String> driverNames = [
    "Peter Parker",
    "John Doe",
    "Peter Parker",
    "John Doe",
  ];

  RxBool isHomeLoading = true.obs;


  RxList<Booking?>? allbookings = <Booking?>[].obs;
  RxList<AllDriver?>? allDrivers = <AllDriver?>[].obs;
  RxString? totalBooking = "0".obs;
  RxString? totalEarning = "0".obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() {
    getHomeData();
    super.onInit();
  }

  getHomeData() async {
    isHomeLoading.value = true;

    try {
      await BaseApiService()
          .get(apiEndPoint: ApiEndPoints().getHomeData, showLoader: false)
          .then((value) {
        refreshController.refreshCompleted();
        isHomeLoading.value = false;
        if (value?.statusCode == 200) {
          HomeDataResponse response = HomeDataResponse.fromJson(value?.data);
          if (response.success ?? false) {
            log(response.data?.toJson().toString()??"dthhdtf");
            allbookings?.value = response.data?.bookings ?? [];
            allDrivers?.value = response.data?.allDrivers ?? [];
            totalBooking?.value = response.data?.totalBooking.toString() ?? "0";
            totalEarning?.value = response.data?.totalEarning.toString() ?? "0";
            Get.find<BaseController>().isAvailable.value = response.data?.loginServiceProviderStatus.toString() ?? "0";
            update();
          } else {
            showSnackBar(message: response.message ?? "");
          }
        } else {
          showSnackBar(message: "Something went wrong, please try again");
        }
      });
    } on Exception catch (e) {
      isHomeLoading.value = false;
      refreshController.refreshCompleted();
    }
  }

  //Booking Action(Accept or Reject Bookingt)
  bookingActionApi(String bookingId, String action, int index) async {
    Map<String, String> data = {"booking_id": bookingId, "action": action};
    try {
      await BaseApiService()
          .post(
              apiEndPoint: ApiEndPoints().providerBookingAction,
              data: data,
              showLoader: true)
          .then((value) async {
        if (value?.statusCode == 200) {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            showSnackBar(
                isSuccess: action == "1",
                title: action == "1" ? "Booking Accepted" : "Booking Rejected",
                message: response.message ?? "");
            allbookings?.removeAt(index);
            getHomeData();
            update();
          } else {
            showSnackBar(message: response.message ?? "");
          }
        } else {
          showSnackBar(message: "Something went wrong, please try again");
        }
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
