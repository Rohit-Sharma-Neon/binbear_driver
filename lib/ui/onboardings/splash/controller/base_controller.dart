import 'dart:developer';
import 'dart:ui' as ui;
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BaseController extends GetxController{

  late BitmapDescriptor defaultMarker;
  late BitmapDescriptor icStartMarkerPin;
  late BitmapDescriptor icEndMarkerPin;

  @override
  void onInit() {
    super.onInit();
    loadMarkers();
  }

  Future<Position?> getCurrentLocation() async {
    showBaseLoader();
    Position? position;
    bool isPermissionGranted = false;
    isPermissionGranted = await checkLocationPermission();
    if (isPermissionGranted) {
      try {
        position = await Geolocator.getCurrentPosition();
        log(
            '\nCurrent Latitude -> ${(position.latitude).toString()}'
            '\nCurrent Longitude -> ${(position.longitude).toString()}'
            '\nCurrent Accuracy -> ${(position.accuracy).toString()}'
        );
      } catch (e) {
        log(e.toString());
      }
    }
    dismissBaseLoader();
    return position;
  }
  Future<bool> checkLocationPermission() async {
    bool returnValue = true;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Location permissions are denied');
        returnValue = false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      returnValue = false;
      await Geolocator.openAppSettings();
      log('Location permissions are permanently denied, we cannot request permissions.');
    }
    return returnValue;
  }


  /// Default Marker Pin
  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
  }
  loadMarkers() async {
    final Uint8List? defaultMarkerBytes = await getBytesFromAsset('assets/images/ic_map_marker.png', 70);
    defaultMarker = BitmapDescriptor.fromBytes(defaultMarkerBytes!);
    final Uint8List? icStartMarkerPinBytes = await getBytesFromAsset('assets/images/ic_start_map_pin.png', 70);
    icStartMarkerPin = BitmapDescriptor.fromBytes(icStartMarkerPinBytes!);
    final Uint8List? icEndMarkerPinBytes = await getBytesFromAsset('assets/images/ic_end_map_pin.png', 70);
    icEndMarkerPin = BitmapDescriptor.fromBytes(icEndMarkerPinBytes!);
  }

}