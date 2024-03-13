import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:binbeardriver/utils/base_debouncer.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart' as as_dio;

class BaseController extends GetxController{

  late BitmapDescriptor defaultMarker;
  late BitmapDescriptor icStartMarkerPin;
  late BitmapDescriptor icEndMarkerPin;
  /// Map AutoComplete Variables
  BaseDebouncer debouncer = BaseDebouncer();
  String sessionToken = "";
  var uuid = const Uuid();
  as_dio.Dio dio = as_dio.Dio();
  RxList<dynamic> searchResultList = <dynamic>[].obs;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadMarkers();
  }

  getSuggestionsList(String input) {
    if (input.isNotEmpty) {
      debouncer.run(() async {
        if (sessionToken.isEmpty) {
          sessionToken = uuid.v4();
        }
        dio = Dio();
        String mapApiKey = "AIzaSyCKM6nu9hXYksgFuz1flo2zQtPRC_lw7NM";
        String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
        String request = '$baseURL?input=$input&key=$mapApiKey&sessiontoken=$sessionToken';
        print("Input: $input");
        as_dio.Response response = await dio.get(request);
        if (response.statusCode == 200) {
          searchResultList.value = response.data['predictions'];
        } else {
          throw Exception('Failed to load predictions');
        }
      });
    }else{
      searchResultList.clear();
      searchResultList.refresh();
    }
  }

  CameraPosition setInitialMapPosition({required double lat, required double long, double? zoom}){
    return CameraPosition(
      target: LatLng(lat,long),
      zoom: zoom??17,
    );
  }

  Future<LatLng?> animateToCurrentLocation({required Completer<GoogleMapController> mapController, double? zoom}) async {
    final GoogleMapController controller = await mapController.future;
    Position? value = await getCurrentLocation();
    if ((value?.latitude??0) != 0 && (value?.longitude??0) != 0) {
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(value?.latitude??0, value?.longitude??0),
          zoom: zoom??17,
        ),
      ));
      return LatLng(value?.latitude??0, value?.longitude??0);
    }else{
      return LatLng(value?.latitude??0, value?.longitude??0);
    }
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