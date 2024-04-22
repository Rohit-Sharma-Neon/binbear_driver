import 'dart:async';
import 'dart:ui';

import 'package:binbeardriver/utils/notification_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

class BackgroundServices {

}

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
  Timer.periodic(const Duration(seconds: 10), (timer) async {
    if (serviceInstance is AndroidServiceInstance) {
      if (await serviceInstance.isForegroundService()) {
        print("Foreground Service Running");
        serviceInstance.setForegroundNotificationInfo(
          title: 'Foreground Service',
          content: 'Content 1 ${DateTime.now()}',
        );
      }else{
        print("Background Service Running");
        serviceInstance.setForegroundNotificationInfo(
          title: 'Background Service',
          content: 'Content 1 ${DateTime.now()}',
        );
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