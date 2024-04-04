import 'dart:async';
import 'dart:io';

import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/backend/base_responses/base_success_response.dart';
import 'package:binbeardriver/ui/driver/jobs_screen/controller/jobs_controller.dart';
import 'package:binbeardriver/ui/onboardings/base_success_screen.dart';
import 'package:binbeardriver/ui/onboardings/splash/controller/base_controller.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart' as dio;
import 'package:binbeardriver/ui/base_components/base_text.dart';

class DriversMapViewController extends GetxController{
  RxString currentWorkStatus = "Pick-Up!".obs;
  Rx<File?>? selectedImageFile = File("").obs;
  List<Marker> markers = <Marker>[];
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(26.8506252, 75.7616548),
    zoom: 14.4746,
  );

  addMarker({required double latitude, required double longitude}) {
    markers.clear();
    markers.add(Marker(
      markerId: const MarkerId("default_marker"),
      position: LatLng(latitude, longitude),
      icon: Get.find<BaseController>().defaultMarker,
    ));
  }

  CameraPosition getInitialCameraPosition({required double lat, required double long}){
    return CameraPosition(
      target: LatLng(lat,long),
      zoom: 15.5,
    );
  }

  Widget getButtonContent(){
    switch (currentWorkStatus.value) {
      case "Pick-Up!": {
        return const BaseText(
          value: "Pick-Up!",
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        );
      }
      case "On The Way": {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(BaseAssets.icOnTheWay),
            const BaseText(
              value: "On The Way",
              fontSize: 14,
              leftMargin: 9,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ],
        );
      }
      case "Deliver Back To Home": {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(BaseAssets.icDeliverBackToHome),
            const BaseText(
              value: "Deliver Back To Home",
              fontSize: 14,
              leftMargin: 9,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ],
        );
      }
      case "Completed": {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(BaseAssets.icCompleted),
            const BaseText(
              value: "Completed",
              fontSize: 14,
              leftMargin: 9,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ],
        );
      }
      default: {
        return const BaseText(
          value: "Pick-Up!",
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        );
      }
    }
  }

  void onButtonTap({required String bookingId}){
    switch (currentWorkStatus.value) {
      case "Pick-Up!": {
        if ((selectedImageFile?.value?.path??"").isNotEmpty) {
          updateDriverStatus(bookingId: bookingId, status: "2").then((value) {
            if (value??false) {
              currentWorkStatus.value = "On The Way";
              selectedImageFile?.value = File("");
            }
          });
        }else{
          showSnackBar(message: "Please Upload A Picture First!");
        }
        break;
      }
      case "On The Way": {
        updateDriverStatus(bookingId: bookingId, status: "3").then((value) {
          if (value??false) {
            currentWorkStatus.value = "Deliver Back To Home";
            selectedImageFile?.value = File("");
          }
        });
        break;
      }
      case "Deliver Back To Home": {
        if ((selectedImageFile?.value?.path??"").isNotEmpty) {
          updateDriverStatus(bookingId: bookingId, status: "4").then((value) {
            if (value??false) {
              currentWorkStatus.value = "Completed";
              selectedImageFile?.value = File("");
            }
          });
        }else{
          showSnackBar(message: "Please Upload A Picture First!");
        }
        break;
      }
      case "Completed": {
        updateDriverStatus(bookingId: bookingId, status: "5").then((value) {
          if (value??false) {
            Get.off(() => BaseSuccessScreen(
              title: "Completed",
              description: "Please continue on to your next\nstop and remember to ALWAYS\ndrive safe!",
              btnTitle: "OK",
              onBtnTap: (){
                Get.back();
                Get.find<JobsController>().getMyJobsApi();
              },
            ));
          }
        });
        break;
      }
      default: {
        currentWorkStatus.value = "Pick-Up!";
        break;
      }
    }
  }

  Future<bool?> updateDriverStatus({required String bookingId, required String status}) async {
    bool returnValue = false;
    dio.FormData data = dio.FormData.fromMap({
      "booking_id":bookingId,
      "status":status,
    });
    if((selectedImageFile?.value?.path??'').isNotEmpty){
      data.files.add(MapEntry("image",await dio.MultipartFile.fromFile(selectedImageFile?.value?.path??'', filename: (selectedImageFile?.value?.path??'').split("/").last)));
    }
    await BaseApiService().post(apiEndPoint: ApiEndPoints().updateDriverStatus, data: data).then((value){
      if (value?.statusCode ==  200) {
        BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
        if (response.success??false) {
          if (status != "5") {
            showSnackBar(isSuccess: true, message: response.message??"");
          }
          returnValue = true;
        }else{
          showSnackBar(message: response.message??"");
          returnValue = false;
        }
      }else{
        showSnackBar(message: "Something went wrong, please try again");
        returnValue = false;
      }
    });
    return returnValue;
  }
}