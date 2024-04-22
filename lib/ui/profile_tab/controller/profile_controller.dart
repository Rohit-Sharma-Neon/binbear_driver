import 'dart:developer';
import 'dart:io';

import 'package:binbeardriver/ui/manual_address/model/saved_address_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dio/dio.dart' as dio;

import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/backend/base_responses/base_success_response.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/get_storage.dart';
import 'package:binbeardriver/utils/storage_keys.dart';
import 'package:binbeardriver/ui/profile_tab/model/profile_response.dart';

class ProfileController extends GetxController {
  RxString selectedGender = "Male".obs;
  File? imageFile;
  Rx<ProfileData?>? profileData = ProfileData().obs;
  RxBool isProfileLoading = false.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  Rx<File?>? selectedImage = File("").obs;
  File? pickedFile = File("");
  Rx<SavedAddressListData> selectedAddress = SavedAddressListData().obs;
  RxString selectedAddressId = "".obs;

  @override
  void onInit() {
    getProfileData();
    super.onInit();
  }

  setData() {
    nameController.text = profileData?.value?.name?.toString() ?? "";
    emailController.text = profileData?.value?.email?.toString() ?? "";
    mobileController.text = MaskTextInputFormatter().updateMask(
            mask: '(###) ###-####',
            newValue: TextEditingValue(text: profileData?.value?.mobile?.toString() ?? "")).text;
    selectedGender.value = (profileData?.value?.gender?.toString().toLowerCase() ?? "male").contains("female")
            ? "Female"
            : "Male";
    update();
  }

  updateProfile() async {
    // Map<String, String> data = {
    //   "name":nameController.text.trim(),
    //   "gender":selectedGender.value,
    // };
    dio.FormData data = dio.FormData.fromMap({
      "name": nameController.text.trim(),
      "gender": selectedGender.value,
      "address_id": selectedAddressId.value,
      "flat_no": selectedAddress.value.flatNo,
      "apartment": selectedAddress.value.apartment,
      "description": selectedAddress.value.description,
      "lat": selectedAddress.value.lat,
      "lng": selectedAddress.value.lng,
      "full_address": selectedAddress.value.fullAddress
    });

    log("${selectedAddress.value.toJson()}");
    if ((selectedImage?.value?.path ?? '').isNotEmpty) {
      data.files.add(MapEntry(
          "profile",
          await dio.MultipartFile.fromFile(selectedImage!.value!.path,
              filename: selectedImage!.value!.path.split("/").last)));
    }
    if ((pickedFile?.path ?? "").isNotEmpty) {
      data.files.add(MapEntry("id_proof",
          await dio.MultipartFile.fromFile((pickedFile?.path ?? ""))));
    }

    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().editUserProfile, data: data)
        .then((value) {
      isProfileLoading.value = false;
      refreshController.refreshCompleted();
      if (value?.statusCode == 200) {
        BaseSuccessResponse response =
            BaseSuccessResponse.fromJson(value?.data);
        if (response.success ?? false) {
          triggerHapticFeedback();
          Get.back();
          // selectedAddressFull.value = "";
          selectedAddressId.value = "";
          selectedAddress.value = SavedAddressListData();
          showSnackBar(isSuccess: true, message: response.message ?? "");
          getProfileData();
          update();
        } else {
          showSnackBar(message: response.message ?? "");
        }
      } else {
        showSnackBar(message: "Something went wrong, please try again");
      }
    });
  }

  getProfileData({bool? showLoader}) async {
    isProfileLoading.value = true;
    try {
      await BaseApiService().get(apiEndPoint: ApiEndPoints().getUserProfile, showLoader: showLoader??false).then((value) {
        isProfileLoading.value = false;
        refreshController.refreshCompleted();
        if (value?.statusCode == 200) {
          ProfileResponse response = ProfileResponse.fromJson(value?.data);
          if (response.success ?? false) {
            BaseStorage.write(StorageKeys.profilePhoto, response.data?.profile ?? "");
            BaseStorage.write(StorageKeys.userName, response.data?.name ?? "");
            profileData?.value = response.data;
            log(response.data?.toJson().toString() ?? "fgjko");
          } else {
            showSnackBar(message: response.message ?? "");
          }
        } else {
          showSnackBar(message: "Something went wrong, please try again");
        }
      });
    } on Exception {
      isProfileLoading.value = false;
      refreshController.refreshCompleted();
    }
  }
}
