import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/backend/base_responses/base_success_response.dart';
import 'package:binbeardriver/ui/driver/jobs_screen/model/my_jobs_response.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class JobsController extends GetxController with GetSingleTickerProviderStateMixin{
  late TabController tabController;
  DateTime currentBackPressTime = DateTime.now();
  GlobalKey<ScaffoldState> jobsScaffoldKey = GlobalKey();


  RxBool isLoading = false.obs;
  RxList<Jobs>? list = <Jobs>[].obs;
  RefreshController upcomingRefreshController =
      RefreshController(initialRefresh: false);
  RefreshController pastRefreshController =
      RefreshController(initialRefresh: false);
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
     getMyJobsApi();
    tabController.addListener(() {
      if (!(tabController.indexIsChanging)) {
        getMyJobsApi();
      }
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<bool> onWillPop() {
    if (jobsScaffoldKey.currentState?.isDrawerOpen??false) {
      jobsScaffoldKey.currentState?.closeDrawer();
      return Future.value(false);
    }else{
      if (tabController.index == 0) {
        DateTime now = DateTime.now();
        if (now.difference(currentBackPressTime) > const Duration(seconds: 1)) {
          currentBackPressTime = now;
          Fluttertoast.showToast(msg: "Press back again to exit app");
          return Future.value(false);
        }
        return Future.value(true);
      }else{
        tabController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.ease);
        return Future.value(false);
      }
    }
  }


  getMyJobsApi() async {
    if (!tabController.indexIsChanging) {
      isLoading.value = true;
      int requestIndex = 1;
      if (tabController.index == 2) {
        requestIndex = 4;
      } else {
        requestIndex = tabController.index + 1;
      }
      Map<String, String> data = {
        "booking_status": requestIndex.toString(),
      };
      try {
        await BaseApiService().post(apiEndPoint: ApiEndPoints().driverHomeData, data: data, showLoader: false).then((value) {
          upcomingRefreshController.refreshCompleted();
          pastRefreshController.refreshCompleted();
          if (value?.statusCode == 200) {
            MyJobsResponse response = MyJobsResponse.fromJson(value?.data);
            if (response.success ?? false) {
              list?.value = response.data?.jobs ?? [];
            } else {
              showSnackBar(message: response.message ?? "");
            }
          } else {
            showSnackBar(message: "Something went wrong, please try again");
          }
          isLoading.value = false;
        });
      } on Exception catch (e) {
        isLoading.value = false;
        upcomingRefreshController.refreshCompleted();
        pastRefreshController.refreshCompleted();
      }
    }
  }

  //Booking Action(Accept or Reject Bookingt)
  bookingActionApi(String bookingId, String action, {required int index}) async {
    Map<String, String> data = {
      "booking_id": bookingId,
      "action": action,
    };
    try {
      await BaseApiService().post(
              apiEndPoint: ApiEndPoints().bookingAction,
              data: data,
              showLoader: true)
          .then((value) {
        if (value?.statusCode == 200) {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            showSnackBar(
                isSuccess: action == "1",
                title: action == "1" ? "Booking Accepted" : "Booking Rejected",
                message: response.message ?? "");
            list?.removeAt(index);
            list?.refresh();
          } else {
            showSnackBar(message: response.message ?? "");
          }
        } else {
          showSnackBar(message: "Something went wrong, please try again");
        }
        isLoading.value = false;
      });
    } on Exception catch (e) {
      isLoading.value = false;
    }
  }
}