import 'dart:async';
import 'dart:io';

import 'package:binbeardriver/ui/base_components/base_text.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

triggerHapticFeedback(){
  HapticFeedback.vibrate();
}

MaskTextInputFormatter usPhoneMask = MaskTextInputFormatter(
    mask: '(###) ###-####',
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
);

String formatBackendDate(String dateString, {bool? getDayFirst}) {
  if (dateString.isNotEmpty && dateString != "null") {
    DateTime date = DateTime.parse(dateString);
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString().substring(0);
    if (getDayFirst??true) {
      return '$day-$month-$year';
    }else{
      return '$year-$month-$day';
    }
  }else{
    return "";
  }
}

void showBaseLoader({bool? showLoader}) {
  if (showLoader??true) {
    Get.context!.loaderOverlay.show();
    Future.delayed( const Duration(seconds: apiTimeOut), () {
      Get.context!.loaderOverlay.hide();
    });
  }
}

void dismissBaseLoader({bool? showLoader}){
  if (showLoader??true) {
    Get.context!.loaderOverlay.hide();
  }
}

showSnackBar({bool? isSuccess, String? title, String? subtitle, BuildContext? context}){
  if (Get.isSnackbarOpen) {
    Get.closeAllSnackbars();
  }else{
    Get.snackbar(
      "", "",
      padding: const EdgeInsets.only(left: 24, right: 18, top: 24, bottom: 24),
      titleText: Row(
        children: [
          Expanded(
            child: BaseText(
              value: (title??"").isEmpty ? (isSuccess??false) ? "Success!" : "Error!" : title??"",
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: (){
              triggerHapticFeedback();
              Get.closeCurrentSnackbar();
            }, child: const Icon(
            Icons.close,
            color: Colors.white,
            size: 20,
          ),
          ),
        ],
      ),
      messageText: BaseText(
        value: subtitle??"",
        fontSize: 13,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(right: horizontalScreenPadding, left: horizontalScreenPadding, top: 18),
      backgroundColor: (isSuccess??false) ? Colors.green.shade900.withOpacity(0.8) : BaseColors.primaryColor.withOpacity(0.8),
      colorText: Colors.white,
    );
  }
}

Future<File?> showMediaPicker({bool? isCropEnabled}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  XFile? pickedFile = XFile("");
  await Get.bottomSheet(
    Container(
        alignment: Alignment.center,
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: horizontalScreenPadding, vertical: horizontalScreenPadding),
        padding: const EdgeInsets.only(top: 5, right: horizontalScreenPadding, left: horizontalScreenPadding),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)
        ),
        child:Column(
          children: [
            Container(
              width: 100,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(30)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      await chooseCameraFile(isCropEnabled).then((value) {
                        if(value!=null) {
                          pickedFile = XFile(value.path);
                        }
                        if (Get.isBottomSheetOpen??false) {
                          Get.back();
                        }
                      });
                      // await ImagePicker().pickImage(source: ImageSource.camera).then((value) {
                      //   pickedFile = value;
                      //   if (Get.isBottomSheetOpen??false) {
                      //     Get.back();
                      //   }
                      // });
                    },
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.camera_alt_outlined, color: BaseColors.secondaryColor, size: 60),
                        BaseText(
                          topMargin: 10,
                          value: "Camera",
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      await chooseGalleryFile(isCropEnabled).then((value) {
                        if(value!=null) {
                          pickedFile = XFile(value.path);
                        }
                        if (Get.isBottomSheetOpen??false) {
                          Get.back();
                        }
                      });
                      // await ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
                      //   pickedFile = value;
                      //   if (Get.isBottomSheetOpen??false) {
                      //     Get.back();
                      //   }
                      // });
                    },
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.photo_library_outlined, color: BaseColors.secondaryColor, size: 60),
                        BaseText(
                          topMargin: 10,
                          value: "Gallery",
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    ),
    backgroundColor: Colors.transparent,
  );
  return File(pickedFile?.path??"");
}


Future<File?> chooseCameraFile(bool? isCropEnabled) async {
  final imgPicker = ImagePicker();
  File? _files;
  dynamic _choosenFile;
  await imgPicker.pickImage(source: ImageSource.camera).then((value) async {
    if (value != null) {
      if(isCropEnabled ?? false){
        _choosenFile = await cropImage(
          File(value.path),
        );
      }else{
        _choosenFile = File(value.path);
      }
    }
  });
  if (_choosenFile != null) {
    _files = File(_choosenFile?.path ?? "");
  }
  return _files;
}

Future<File?> chooseGalleryFile(bool? isCropEnabled) async {
  final imgPicker = ImagePicker();
  File? _files;
  dynamic _choosenFile;
  await imgPicker.pickImage(source: ImageSource.gallery).then((value) async {
    if (value != null) {
      if (isCropEnabled ?? false) {
        _choosenFile = await cropImage(
          File(value.path),
        );
      } else {
        _choosenFile = File(value.path);
      }

    }});
  if (_choosenFile != null) {
    _files = File(_choosenFile?.path ?? "");
  }
  return _files;
}

Future<CroppedFile?> cropImage(File imageFile) async {
  CroppedFile? croppedFile;
  await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    aspectRatioPresets: [CropAspectRatioPreset.square],
    aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          activeControlsWidgetColor:Colors.black,
          toolbarColor: CupertinoColors.white,
          toolbarWidgetColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true),
      IOSUiSettings(
          title: 'Cropper',rotateButtonsHidden: true,
          aspectRatioLockEnabled: true
      ),
    ],
  ).then((value) {
    croppedFile = value;

  });
  return croppedFile;
}


String getAddressTypeNameByID({required String addressTypeID}){
  switch (addressTypeID) {
    case "1": return "Home";
    case "2": return "Work";
    case "3": return "Friends & Family";
    case "4": return "Other";
    default: return "Home";
  }
}

String getAddressTypeNumber({required String getAddressTypeName}){
  switch (getAddressTypeName) {
    case "Home": return "1";
    case "Work": return "2";
    case "Friends & Family": return "3";
    case "Other": return "4";
    default: return "1";
  }
}
