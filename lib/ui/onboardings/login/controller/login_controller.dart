import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/storage_keys.dart';

class LoginController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString selectedUserType = "Service Provider".obs;
  final GetStorage box = GetStorage();

  @override
  void onInit() {
    box.write(StorageKeys.isUserDriver, false);
    super.onInit();
  }
}