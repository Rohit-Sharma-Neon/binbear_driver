import 'package:binbeardriver/ui/map_view/map_view_screen.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:binbeardriver/ui/base_components/animated_column.dart';
import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_button.dart';
import 'package:binbeardriver/ui/base_components/base_container.dart';
import 'package:binbeardriver/ui/base_components/base_scaffold_background.dart';
import 'package:binbeardriver/ui/base_components/base_text.dart';
import 'package:binbeardriver/ui/onboardings/splash/controller/base_controller.dart';
import 'package:binbeardriver/ui/onboardings/location/controller/onboarding_location_controller.dart';

class OnboardingLocationScreen extends StatelessWidget {
  OnboardingLocationScreen({super.key,this.showSavedAddress, this.isEditProfile, this.lat, this.long, this.isUpdatingMapLocation});
  final bool? showSavedAddress, isUpdatingMapLocation;
  final double? lat, long;
  final bool? isEditProfile;
  final OnBoardingLocationController controller = Get.put(OnBoardingLocationController());
  final BaseController baseController = Get.find<BaseController>();

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        appBar: const BaseAppBar(),
        body: SingleChildScrollView(
          child: AnimatedColumn(
            children: [
              BaseContainer(
                topPadding: 20,
                child: AnimatedColumn(
                  children: [
                    Image.asset(
                      BaseAssets.icLocation,
                      width: 210,
                      height: 210,
                      fit: BoxFit.fitHeight,
                    ),
                    const BaseText(
                      value: "Address",
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    const BaseText(
                      topMargin: 10,
                      value: "Please allow us to fetch your\nlocation, or you can add your\nlocation manually.",
                      fontSize: 15,
                      textAlign: TextAlign.center,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    // BaseButton(
                    //   topMargin: 35,
                    //   title: "Enable Location",
                    //   btnColor: BaseColors.secondaryColor,
                    //   onPressed: (){
                    //     showBaseLoader();
                    //     baseController.getCurrentLocation(showLoader: false).then((value) async {
                    //       if ((value?.latitude.toString()??"").isNotEmpty && (value?.longitude.toString()??"").isNotEmpty) {
                    //         var placeMarks = await placemarkFromCoordinates(value?.latitude??0, value?.longitude??0);
                    //         Placemark place = placeMarks[0];
                    //         String finalAddress = '${place.name}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}';
                    //         dismissBaseLoader();
                    //         Get.to(()=> MapViewScreen(
                    //           lat: value?.latitude??0,
                    //           long: value?.longitude??0,
                    //           fullAddress: finalAddress,
                    //           mainAddress: place.street,
                    //           subAddress: "${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}",
                    //           showSavedAddress: showSavedAddress??false,
                    //         ));
                    //       }
                    //     });
                    //   },
                    // ),
                    BaseButton(
                      topMargin: 18,
                      title: (isEditProfile??false) ? "Update Location" : "Add Location",
                      // onPressed: (){
                      //   Get.to(() =>  ManualAddressScreen(showSavedAddress: showSavedAddress,isEditProfile: isEditProfile ?? false,));
                      // },
                      onPressed: () async {
                        if (isEditProfile??false) {
                          if ((lat?.toString()??"").isNotEmpty && (long?.toString()??"").isNotEmpty) {
                            var placeMarks = await placemarkFromCoordinates(lat??0, long??0);
                            Placemark place = placeMarks[0];
                            String finalAddress = '${place.name}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}';
                            dismissBaseLoader();
                            Get.to(()=> MapViewScreen(
                              lat: lat??0,
                              long: long??0,
                              isUpdatingMapLocation: isUpdatingMapLocation,
                              fullAddress: finalAddress,
                              mainAddress: place.street,
                              subAddress: "${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}",
                              showSavedAddress: showSavedAddress??false,
                            ));
                          }else{
                            showSnackBar(message: "Please Try Again!");
                          }
                        }else{
                          showBaseLoader();
                          baseController.getCurrentLocation(showLoader: false).then((value) async {
                            if ((value?.latitude.toString()??"").isNotEmpty && (value?.longitude.toString()??"").isNotEmpty) {
                              var placeMarks = await placemarkFromCoordinates(value?.latitude??0, value?.longitude??0);
                              Placemark place = placeMarks[0];
                              String finalAddress = '${place.name}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}';
                              dismissBaseLoader();
                              Get.to(()=> MapViewScreen(
                                lat: value?.latitude??0,
                                long: value?.longitude??0,
                                fullAddress: finalAddress,
                                mainAddress: place.street,
                                subAddress: "${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}",
                                showSavedAddress: showSavedAddress??false,
                              ));
                            }else{
                              showSnackBar(message: "Please Try Again!");
                            }
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
