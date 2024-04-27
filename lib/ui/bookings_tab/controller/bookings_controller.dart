import 'dart:async';

import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/backend/base_responses/base_success_response.dart';
import 'package:binbeardriver/ui/bookings_tab/model/bookings_response.dart';
import 'package:binbeardriver/ui/onboardings/splash/controller/base_controller.dart';
import 'package:binbeardriver/ui/service_provider_map_view/model/driver_lat_lng_response.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BookingsController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  Set<Marker> markers = {};
  Completer<GoogleMapController> mapCompleter = Completer<GoogleMapController>();
  late GoogleMapController mapController;
  late LatLngBounds bound;
  List<LatLng> polylineCoordinates = <LatLng>[];
  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};

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

  addMarker({required double latitude, required double longitude}) {
    markers.clear();
    polylines.clear();
    polylineCoordinates.clear();
    markers.add(Marker(
      markerId: const MarkerId("default_marker"),
      position: LatLng(latitude, longitude),
      icon: Get.find<BaseController>().icEndMarkerPin,
    ));
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
        await BaseApiService().post(apiEndPoint: ApiEndPoints().myBookings, data: data, showLoader: false).then((value) {
          upcomingRefreshController.refreshCompleted();
          pastRefreshController.refreshCompleted();
          if (value?.statusCode == 200) {
            MyBookingsResponse response =
                MyBookingsResponse.fromJson(value?.data);
            if (response.success ?? false) {
              list?.value = response.data?.bookings ?? [];
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
// Get Driver Location
  Future<LatLng> getUpdatedDriverLocation({required String bookingId}) async {
    LatLng returnValue = const LatLng(0, 0);
    Map<String, String> data = {
      "booking_id": bookingId,
    };
    try {
      await BaseApiService().post(apiEndPoint: ApiEndPoints().getDriverLocation, data: data, showLoader: false).then((value) {
        if (value?.statusCode == 200) {
          DriverLatLngResponse response = DriverLatLngResponse.fromJson(value?.data);
          if (response.success ?? false) {
            returnValue = LatLng(double.parse(response.data?.lat?.toString()??"0"), double.parse(response.data?.lng?.toString()??"0"));
          }
        }
      });
    } on Exception catch (e) {
      print(e.toString());
    }
    return returnValue;
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
            list?.removeAt(index);
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
