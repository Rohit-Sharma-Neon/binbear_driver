import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../onboardings/splash/controller/base_controller.dart';

class BookingsController extends GetxController with GetSingleTickerProviderStateMixin{
  late TabController tabController;
  List<Marker> markers = <Marker>[];
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  addMarkers({required double startingLat, required double startingLong, required double endingLat, required double endingLong}) {
    markers.clear();
    markers.add(Marker(
      markerId: const MarkerId("starting_marker"),
      position: LatLng(startingLat, startingLong),
      infoWindow: const InfoWindow(
        title: "Starting Location",
      ),
      icon: Get.find<BaseController>().icStartMarkerPin,
    ));
    markers.add(Marker(
      markerId: const MarkerId("ending_marker"),
      position: LatLng(endingLat, endingLong),
      infoWindow: const InfoWindow(
        title: "Ending Location",
      ),
      icon: Get.find<BaseController>().icEndMarkerPin,
    ));
  }

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(26.8506252, 75.7616548),
    zoom: 14.4746,
  );

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }


}