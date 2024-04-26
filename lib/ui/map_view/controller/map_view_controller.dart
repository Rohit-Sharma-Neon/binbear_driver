import 'dart:async';
import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/backend/base_responses/base_success_response.dart';
import 'package:binbeardriver/ui/dashboard_module/dashboard_screen/dashboard_screen.dart';
import 'package:binbeardriver/ui/driver/jobs_screen/jobs_screen.dart';
import 'package:binbeardriver/ui/onboardings/base_success_screen.dart';
import 'package:binbeardriver/ui/onboardings/welcome_screen.dart';
import 'package:binbeardriver/ui/profile_tab/controller/profile_controller.dart';
import 'package:binbeardriver/utils/base_debouncer.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/base_strings.dart';
import 'package:binbeardriver/utils/get_storage.dart';
import 'package:binbeardriver/utils/storage_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart' as as_dio;
import 'package:uuid/uuid.dart';
import 'package:binbeardriver/ui/onboardings/splash/controller/base_controller.dart';

class MapViewController extends GetxController{
  Completer<GoogleMapController> mapController = Completer();
  final BaseController baseController = Get.find<BaseController>();
  List<Marker> markers = <Marker>[];
  RxString selectedLocation = "".obs;

  BaseDebouncer debouncer = BaseDebouncer();
  String sessionToken = "";
  var uuid = const Uuid();
  as_dio.Dio dio = as_dio.Dio();
  RxList<dynamic> searchResultList = <dynamic>[].obs;
  TextEditingController searchController = TextEditingController();
  onChanged() {
    if (sessionToken.isEmpty) {
      sessionToken = uuid.v4();
    }
    getSuggestion(searchController.text);
  }

  updateAddress({required double lat, required double lng, required String fullAddress, bool? showSavedAddress, String? addressId, String? house, String? apartment, String? description}) {
    Map<String, String> data = {
      "flat_no": house??"",
      "apartment": apartment??"",
      "description": description??"",
      "home_type": "2", // default type is "2" defined by backend
      "full_address": fullAddress,
      "lat": lat.toString(),
      "lng": lng.toString(),
    };
    if((addressId??"").isNotEmpty){
      data["address_id"] = addressId??"";
    }
    BaseApiService().post(apiEndPoint: ApiEndPoints().addAddress, data: data).then((value) async {
      if (value?.statusCode == 200) {
        BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
        if (response.success ?? false) {
          if (showSavedAddress ?? false) {
            Get.back();
            Get.find<ProfileController>().getProfileData();
          }
        } else {
          showSnackBar(message: response.message ?? "");
        }
      } else {
        showSnackBar(message: "Something went wrong, please try again");
      }
    });
  }


  getSuggestion(String input) async {
    dio = Dio();
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$googleApiKey&sessiontoken=$sessionToken';
    as_dio.Response response = await dio.get(request);
    if (response.statusCode == 200) {
        searchResultList.value = response.data['predictions'];
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  CameraPosition getInitialCameraPosition({required double lat, required double long}){
    return CameraPosition(
      target: LatLng(lat,long),
      zoom: 17,
    );
  }

  addMarker({required double latitude, required double longitude}) {
     markers.clear();
     markers.add(Marker(
       markerId: const MarkerId("default_marker"),
       position: LatLng(latitude, longitude),
       icon: Get.find<BaseController>().defaultMarker,
     ));
  }

  locateToCurrentLocation() async {
    final GoogleMapController controller = await mapController.future;
    await baseController.getCurrentLocation().then((value) {
      if (value?.latitude != null && value?.longitude != null) {
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 0,
            target: LatLng(value?.latitude??0, value?.longitude??0),
            zoom: 17,
          ),
        ));
        addMarker(latitude: value?.latitude??0, longitude: value?.longitude??0);
      }
    });
    update();
  }

  animateToLocation({required LatLng value}) async {
    final GoogleMapController controller = await mapController.future;
      if (value.latitude != 0 && value.longitude != 0) {
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 0,
            target: LatLng(value.latitude??0, value.longitude??0),
            zoom: 17,
          ),
        ));
        addMarker(latitude: value.latitude??0, longitude: value.longitude??0);
      }
    update();
  }
}