import 'dart:async';

import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/ui/driver_exact_location/model/booking_details_response.dart';
import 'package:binbeardriver/ui/onboardings/base_success_screen.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:binbeardriver/ui/base_components/base_text.dart';

class DriverExactLocationController extends GetxController {
  RxString currentWorkStatus = "Pick-Up!".obs;

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  late GoogleMapController googleMapController;
  RxBool isLoading = false.obs;
  Rx<BookingDetailData?> bookingDetailData = BookingDetailData().obs;
  @override
  void onInit() {
    currentWorkStatus.value = "Pick-Up!";
    super.onInit();
  }

  CameraPosition getInitialCameraPosition({required LatLng latLng}) {
    return CameraPosition(
      target: latLng,
      zoom: 14,
    );
  }

  Widget getButtonContent() {
    switch (currentWorkStatus.value) {
      case "Pick-Up!":
        {
          return const BaseText(
            value: "Pick-Up!",
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          );
        }
      case "On The Way":
        {
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
      case "Deliver Back To Home":
        {
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
      case "Completed":
        {
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
      default:
        {
          return const BaseText(
            value: "Pick-Up!",
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          );
        }
    }
  }

  void onButtonTap() {
    switch (currentWorkStatus.value) {
      case "Pick-Up!":
        {
          currentWorkStatus.value = "On The Way";
          break;
        }
      case "On The Way":
        {
          currentWorkStatus.value = "Deliver Back To Home";
          break;
        }
      case "Deliver Back To Home":
        {
          currentWorkStatus.value = "Completed";
          break;
        }
      case "Completed":
        {
          Get.off(() => BaseSuccessScreen(
                title: "Completed",
                description:
                    "Please continue on to your next\nstop and remember to ALWAYS\ndrive safe!",
                btnTitle: "OK",
                onBtnTap: () {
                  Get.back();
                },
              ));
          break;
        }
      default:
        {
          currentWorkStatus.value = "Pick-Up!";
          break;
        }
    }
  }

  getMyBookingsApi(String bookingId) async {
    isLoading.value = true;

    Map<String, String> data = {
      "booking_id": bookingId,
    };
    try {
      await BaseApiService()
          .post(
              apiEndPoint: ApiEndPoints().bookingsDetails,
              data: data,
              showLoader: true)
          .then((value) async {
        if (value?.statusCode == 200) {
          BookingDetailsResponse response =
              BookingDetailsResponse.fromJson(value?.data);
          if (response.success ?? false) {
            bookingDetailData.value = response.data;
            googleMapController = await mapController.future;

            googleMapController
                .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                    target: LatLng(
                      double.parse(
                          "${bookingDetailData.value?.pickupAddress?.lat ?? "0"}"),
                      double.parse(
                          "${bookingDetailData.value?.pickupAddress?.lng ?? "0"}"),
                    ),
                    zoom: 14)));
            update(); 
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
