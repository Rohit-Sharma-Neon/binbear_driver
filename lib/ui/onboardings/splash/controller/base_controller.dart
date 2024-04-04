import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/backend/base_responses/autocomplete_api_response.dart';
import 'package:binbeardriver/backend/base_responses/base_success_response.dart';
import 'package:binbeardriver/ui/manual_address/model/saved_address_response.dart';
import 'package:binbeardriver/utils/base_debouncer.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/base_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart' as as_dio;

import 'package:binbeardriver/ui/drivers_listing/model/driverlist_response.dart';

class BaseController extends GetxController{

  late BitmapDescriptor defaultMarker;
  late BitmapDescriptor icStartMarkerPin;
  late BitmapDescriptor icEndMarkerPin;

  RxBool isAddressTappedOnSignUp = false.obs;
  /// Map AutoComplete Variables
  BaseDebouncer debouncer = BaseDebouncer();
  String sessionToken = "";
  var uuid = const Uuid();
  as_dio.Dio dio = as_dio.Dio();
  RxList<AutoCompleteResult> searchResultList = <AutoCompleteResult>[].obs;
  TextEditingController searchController = TextEditingController();
  RxBool isAddressSuggestionLoading = false.obs;
  RxBool isSavedAddressLoading = false.obs;
  RxList<SavedAddressListData>? savedAddressList = <SavedAddressListData>[].obs;
  RefreshController savedAddressRefreshController = RefreshController(initialRefresh: false);
  // driver listing
  RxInt selectedDriverIndex = 0.obs;
  RxList<DriverData>? listDriver = <DriverData>[].obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    loadMarkers();
  }

  getSuggestionsList(String input) {
    if (input.isNotEmpty) {
      debouncer.run(() async {
        isAddressSuggestionLoading.value = true;
        if (sessionToken.isEmpty) {
          sessionToken = uuid.v4();
        }
        dio = as_dio.Dio();
        String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
        String request = '$baseURL?input=$input&key=$googleApiKey&sessiontoken=$sessionToken';
        as_dio.Response response = await dio.get(request);
        AutoCompleteApiResponse autoCompleteApiResponse = AutoCompleteApiResponse.fromJson(response.data);
        isAddressSuggestionLoading.value = false;
        if ((autoCompleteApiResponse.status?.toString().toLowerCase()??"") == "ok") {
          searchResultList.value = autoCompleteApiResponse.predictions??[];
        } else {
          throw Exception('Failed to load predictions');
        }
      });
    }else{
      searchResultList.clear();
      searchResultList.refresh();
    }
  }

  Future<LatLng?> getLatLngFromAddress({required String address}) async {
    var locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      return LatLng(locations.first.latitude, locations.first.longitude);
    }else {
      return const LatLng(0, 0);
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

  getSavedAddress() async {
    isSavedAddressLoading.value = true;
    savedAddressList?.clear();
    savedAddressList?.refresh();
    update();
    try {
      await BaseApiService().get(apiEndPoint: ApiEndPoints().addressList, showLoader: false).then((value){
        savedAddressRefreshController.refreshCompleted();
        if (value?.statusCode ==  200) {
          SavedAddressListResponse response = SavedAddressListResponse.fromJson(value?.data);
          if (response.success??false) {
            savedAddressList?.value = response.data??[];
          }else{
            showSnackBar(message: response.message??"");
          }
        }else{
          showSnackBar(message: "Something went wrong, please try again");
        }
        isSavedAddressLoading.value = false;
        update();
      });
    } on Exception catch (e) {
      isSavedAddressLoading.value = false;
      savedAddressRefreshController.refreshCompleted();
      update();
    }
  }

  Future<bool> setDefaultAddress({required String addressID}) async {
    Map<String, String> data = {
      "address_id":addressID.toString(),
      "is_default":"1",
    };
    bool returnValue = false;
    try {
      await BaseApiService().post(apiEndPoint: ApiEndPoints().setDefaultAddress, data: data).then((value){
        if (value?.statusCode ==  200) {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success??false) {
            returnValue = true;
          }else{
            showSnackBar(message: response.message??"");
          }
        }else{
          showSnackBar(message: "Something went wrong, please try again");
        }
        return returnValue;
      });

    } on Exception catch (e) {
      print(e.toString());
    }
    return returnValue;
  }

  Future<bool> createBooking({required String serviceTypeId, String? subServiceId, String? noOfCans, String? price, String? addressId, String? couponId}) async {
    Map<String, String> data = {
      "category_id":serviceTypeId,
      "sub_category_id":subServiceId??"",
      "no_of_cane":noOfCans??"",
      "price":price??"",
      "address_id":addressId??"",
      "coupon_id":couponId??"",
    };
    bool returnValue = false;
    try {
      await BaseApiService().post(apiEndPoint: ApiEndPoints().bookingCreate, data: data).then((value){
        if (value?.statusCode ==  200) {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success??false) {
            returnValue = true;
          }else{
            showSnackBar(message: response.message??"");
          }
        }else{
          showSnackBar(message: "Something went wrong, please try again");
        }
        return returnValue;
      });

    } on Exception catch (e) {
      print(e.toString());
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

  driverList() {
    try {
      BaseApiService().post(apiEndPoint: ApiEndPoints().driverList).then((value) {
        if (value?.statusCode == 200) {
          DriverList response = DriverList.fromJson(value?.data);
          if (response.success ?? false) {
            listDriver?.value = response.data ?? [];
          } else {
            showSnackBar(message: response.message ?? "");
          }
        } else {
          showSnackBar(message: "Something went wrong, please try again");
        }
      });
    } on Exception catch (e) {
      refreshController.refreshCompleted();
    }
  }


  assignBooking(String id ,String bookingId) {
    Map<String, String> data = {
     'binbear_id': id,
     'booking_id': bookingId
    };
    try {
      BaseApiService().post(apiEndPoint: ApiEndPoints().assignBooking,data: data,showLoader: true).then((value) {
        if (value?.statusCode == 200) {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            Get.back();
            Get.back();
            showSnackBar(message: response.message ?? "",isSuccess:true);
          } else {
            showSnackBar(message: response.message ?? "");
          }
        } else {
          showSnackBar(message: "Something went wrong, please try again");
        }
      });
    } on Exception catch (e) {
      refreshController.refreshCompleted();
    }
  }


  deleteDriver(dynamic id ,int index){
    Map<String, dynamic> params = {'binbear_id': id};

    BaseApiService().post(apiEndPoint: ApiEndPoints().driverDelete,data: params).then((value){
      if (value?.statusCode ==  200) {
        BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
        if (response.success??false) {
          triggerHapticFeedback();
          showSnackBar(message: response.message??"", isSuccess: true);
          listDriver?.removeAt(index);
        }else{
          showSnackBar(message: response.message??"");
        }
      }else{
        showSnackBar(message: "Something went wrong, please try again");
      }
    });
  }
}