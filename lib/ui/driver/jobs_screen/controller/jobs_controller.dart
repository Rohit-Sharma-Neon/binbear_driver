import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class JobsController extends GetxController with GetSingleTickerProviderStateMixin{
  late TabController tabController;
  DateTime currentBackPressTime = DateTime.now();
  GlobalKey<ScaffoldState> jobsScaffoldKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
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

}