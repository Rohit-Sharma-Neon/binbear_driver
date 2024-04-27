import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/ui/onboardings/splash/controller/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> initializeBackgroundService() async {
  final FlutterBackgroundService service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(
        onForeground: onStart,
      ),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          isForegroundMode: true,
      )
  );
  service.startService();
}
@pragma('vm:entry-point')
void onStart(ServiceInstance serviceInstance){
  DartPluginRegistrant.ensureInitialized();
  if (serviceInstance is AndroidServiceInstance) {
      serviceInstance.on('setAsForeground').listen((event) {
      serviceInstance.setAsForegroundService();
    });
    serviceInstance.on('setAsBackground').listen((event) {
      serviceInstance.setAsBackgroundService();
    });
    serviceInstance.on('stopService').listen((event) {
      serviceInstance.stopSelf();
    });
  }
  Timer.periodic(const Duration(seconds: 5), (timer) async {
    if (serviceInstance is AndroidServiceInstance) {
      if (await serviceInstance.isForegroundService()) {
        serviceInstance.setForegroundNotificationInfo(
          title: 'BinBear Service',
          content: 'Fetching Driver Location ${DateTime.now()}',
        );
        sendDriverLatLng();
      }
    }
    serviceInstance.invoke('update');
  });
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance serviceInstance) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

sendDriverLatLng() {
  getCurrentLocation(showLoader: false).then((value) async {
    Map<String, String> data = {
      "lat": (value?.latitude??0).toString(),
      "lng": (value?.longitude??0).toString(),
    };
    try {
      BaseApiService().post(apiEndPoint: ApiEndPoints().driverLocationUpdate, data: data, showLoader: false);
    } on Exception catch (e) {
      print(e.toString());
    }
  });
}

Future<Position?> getCurrentLocation({bool? showLoader}) async {
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
      return position;
    }
  }
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

Future<bool> checkNotificationPermission() async {
  bool returnValue = true;
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  return returnValue;
}