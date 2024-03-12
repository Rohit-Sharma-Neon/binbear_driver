import 'package:get/get.dart';

class HomeTabController extends GetxController{

  RxInt selectedDriverIndex = 0.obs;
  List<String> driverNames = [
    "Peter Parker",
    "John Doe",
    "Peter Parker",
    "John Doe",
  ];
}