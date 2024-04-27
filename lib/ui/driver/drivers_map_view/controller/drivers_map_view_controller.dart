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
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart' as dio;
import 'package:binbeardriver/ui/base_components/base_text.dart';
import 'package:url_launcher/url_launcher.dart';

class DriversMapViewController extends GetxController{
  RxString currentWorkStatus = "0".obs;
  Rx<File?>? selectedImageFile = File("").obs;
  List<Marker> markers = <Marker>[];
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  List<LatLng> polylineCoordinates = <LatLng>[];
  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};

  late LatLngBounds bound;
  addMarkersAndPolyLines({required LatLng southwest, required LatLng northeast}) async {
    polylinePoints = PolylinePoints();
    markers.clear();
    polylineCoordinates.clear();
    bound = LatLngBounds(southwest: southwest, northeast: northeast);
    markers.add(Marker(
      markerId: const MarkerId("starting_marker"),
      position: southwest,
      infoWindow: const InfoWindow(
        title: "Starting Location",
      ),
      icon: Get.find<BaseController>().icStartMarkerPin,
    ));
    markers.add(Marker(
      markerId: const MarkerId("ending_marker"),
      position: northeast,
      infoWindow: const InfoWindow(
        title: "Ending Location",
      ),
      icon: Get.find<BaseController>().icEndMarkerPin,
    ));

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyB_VFamRk_pFl6r2rW2eCex13FweyndFm0", // Google Maps API Key
      PointLatLng(southwest.latitude, southwest.longitude),
      PointLatLng(northeast.latitude, northeast.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    PolylineId id = const PolylineId('poly');

    Polyline polyline = Polyline(
      polylineId: id,
      color: const Color(0xffDE875A),
      points: polylineCoordinates,
      width: 3,
    );

    polylines[id] = polyline;
    update();
  }


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
      case "1": {
        return const BaseText(
          value: "Start",
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        );
      }
      case "7": {
        return const BaseText(
          value: "Pick-Up!",
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        );
      }
      case "2": {
        return const BaseText(
          value: "On The Way",
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        );
      }
      case "3": {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(BaseAssets.icOnTheWay),
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
      case "4": {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(BaseAssets.icDeliverBackToHome),
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
      case "5": {
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
      case "6": {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(BaseAssets.icCompleted),
            const BaseText(
              value: "Rejected",
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

  Future<void> onButtonTap({required String bookingId, required int index, double? lat, double? lng}) async {
    switch (currentWorkStatus.value) {
      case "1": {
        // 1 -> Accepted
        launchGoogleMap(lat: lat??0, lng: lng??0);
        updateDriverStatus(bookingId: bookingId, status: "7").then((value) {
          if (value??false) {
            Get.find<JobsController>().list?[index].serviceStatus = "7";
            Get.find<JobsController>().list?.refresh();
            currentWorkStatus.value = "7";
            selectedImageFile?.value = File("");
          }
        });
        break;
      }
      case "7": {
        // 7 -> Started
        if ((selectedImageFile?.value?.path??"").isNotEmpty) {
          updateDriverStatus(bookingId: bookingId, status: "2").then((value) {
            if (value??false) {
              Get.find<JobsController>().list?[index].serviceStatus = "2";
              Get.find<JobsController>().list?.refresh();
              currentWorkStatus.value = "2";
              selectedImageFile?.value = File("");
            }
          });
        }else{
          showSnackBar(message: "Please Upload A Picture First!");
        }
        break;
      }
      case "2": {
        // 2 -> Pick Up
        updateDriverStatus(bookingId: bookingId, status: "3").then((value) {
          if (value??false) {
            Get.find<JobsController>().list?[index].serviceStatus = "3";
            Get.find<JobsController>().list?.refresh();
            currentWorkStatus.value = "3";
            selectedImageFile?.value = File("");
          }
        });
        break;
      }
      case "3": {
        // 3 -> On The Way
        if ((selectedImageFile?.value?.path??"").isNotEmpty) {
          updateDriverStatus(bookingId: bookingId, status: "4").then((value) {
            if (value??false) {
              Get.find<JobsController>().list?[index].serviceStatus = "4";
              Get.find<JobsController>().list?.refresh();
              currentWorkStatus.value = "4";
              selectedImageFile?.value = File("");
            }
          });
        }else{
          showSnackBar(message: "Please Upload A Picture First!");
        }
        break;
      }
      case "4": {
        // 4 -> Deliver Back To Home
        updateDriverStatus(bookingId: bookingId, status: "5").then((value) {
          if (value??false) {
            Get.find<JobsController>().list?[index].serviceStatus = "5";
            Get.find<JobsController>().list?.refresh();
            currentWorkStatus.value = "5";
            selectedImageFile?.value = File("");
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
        Get.find<JobsController>().list?[index].serviceStatus = "2";
        Get.find<JobsController>().list?.refresh();
        currentWorkStatus.value = "Pick-Up!";
        break;
      }
    }
  }

  void launchGoogleMap({required double lat, required double lng}) async {
    final Uri url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
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