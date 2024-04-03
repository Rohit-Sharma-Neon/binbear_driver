import 'dart:async';

import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/backend/base_responses/base_success_response.dart';
import 'package:binbeardriver/ui/bookings_tab/model/bookings_response.dart';
import 'package:binbeardriver/ui/onboardings/splash/controller/base_controller.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BookingsController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  Set<Marker> markers = {};
  Completer<GoogleMapController> mapCompleter =
      Completer<GoogleMapController>();
  late GoogleMapController mapController;
  late LatLngBounds bound;
  List<LatLng> polylineCoordinates = <LatLng>[];
  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  addMarkers({required LatLng southwest, required LatLng northeast}) async {
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
      "AIzaSyCKM6nu9hXYksgFuz1flo2zQtPRC_lw7NM", // Google Maps API Key
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
      color: BaseColors.primaryColor,
      points: polylineCoordinates,
      width: 2,
    );

    polylines[id] = polyline;
    update();
  }

  onMapCreated(GoogleMapController googleMapController) async {
    mapController = await mapCompleter.future;
    if (!mapCompleter.isCompleted) {
      mapCompleter.complete(googleMapController);
    }
    update();
    googleMapController.animateCamera(CameraUpdate.newLatLngBounds(bound, 50));
    update();
  }

  CameraPosition getInitialCameraPosition(
      {required double lat, required double long}) {
    return CameraPosition(
      target: LatLng(lat, long),
      zoom: 17,
    );
  }

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(26.8506252, 75.7616548),
    zoom: 14.4746,
  );

  // @override
  // void onInit() {
  //   super.onInit();
  //   tabController = TabController(length: 3, vsync: this);
  // }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  RxBool isLoading = false.obs;
  RxList<Booking>? list = <Booking>[].obs;
  RefreshController upcomingRefreshController =
      RefreshController(initialRefresh: false);
  RefreshController pastRefreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    getMyBookingsApi();
    tabController.addListener(() {
      if (!(tabController.indexIsChanging)) {
        getMyBookingsApi();
      }
    });
  }

  getMyBookingsApi() async {
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
        await BaseApiService()
            .post(
                apiEndPoint: ApiEndPoints().myBookings,
                data: data,
                showLoader: false)
            .then((value) {
          upcomingRefreshController.refreshCompleted();
          pastRefreshController.refreshCompleted();
          if (value?.statusCode == 200) {
            MyBookingsResponse response =
                MyBookingsResponse.fromJson(value?.data);
            if (response.success ?? false) {
              list?.value = response.data?.bookings ?? [];
            } else {
              showSnackBar(subtitle: response.message ?? "");
            }
          } else {
            showSnackBar(subtitle: "Something went wrong, please try again");
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
  bookingActionApi(String bookingId, String action, int index) async {
    Map<String, String> data = {"booking_id": bookingId, "action": action};
    try {
      await BaseApiService()
          .post(
              apiEndPoint: ApiEndPoints().bookingAction,
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
                 subtitle: response.message ?? "");
              list?.removeAt(index);
            update();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } else {
          showSnackBar(subtitle: "Something went wrong, please try again");
        }
        isLoading.value = false;
      });
    } on Exception catch (e) {
      isLoading.value = false;
    }
  }
}
