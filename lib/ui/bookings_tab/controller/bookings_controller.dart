import 'dart:async';

import 'package:binbeardriver/utils/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../onboardings/splash/controller/base_controller.dart';

class BookingsController extends GetxController with GetSingleTickerProviderStateMixin{
  late TabController tabController;
  Set<Marker> markers = {};
  Completer<GoogleMapController> mapCompleter = Completer<GoogleMapController>();
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
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
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

  CameraPosition getInitialCameraPosition({required double lat, required double long}){
    return CameraPosition(
      target: LatLng(lat,long),
      zoom: 17,
    );
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