import 'package:binbeardriver/ui/base_components/custom_radio_button.dart';
import 'package:binbeardriver/ui/onboardings/location/onboarding_location_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/ui/base_components/animated_column.dart';
import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_button.dart';
import 'package:binbeardriver/ui/base_components/base_container.dart';
import 'package:binbeardriver/ui/base_components/base_scaffold_background.dart';
import 'package:binbeardriver/ui/base_components/base_text.dart';
import 'package:binbeardriver/ui/base_components/base_textfield.dart';
import 'package:binbeardriver/ui/manual_address/components/manual_address_list_tile.dart';
import 'package:binbeardriver/ui/manage_address/controller/manage_address_controller.dart';

class ManageAddressScreen extends StatefulWidget {
  final double? lat, long;
  final String? fullAddress, houseNo, apartment, description, addressId;
  final bool? showSavedAddress, isUpdatingMapLocation;
  const ManageAddressScreen({super.key, this.lat, this.long, this.fullAddress, this.showSavedAddress, this.houseNo, this.apartment, this.description, this.addressId, this.isUpdatingMapLocation});
  @override
  State<ManageAddressScreen> createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  ManageAddressController controller = Get.put(ManageAddressController());

  @override
  void initState() {
    super.initState();
    controller.houseNoController.text = widget.houseNo?.toString()??"";
    controller.apartmentController.text = widget.apartment?.toString()??"";
    controller.landmarkController.text = widget.description?.toString()??"";
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        appBar: const BaseAppBar(),
        body: SingleChildScrollView(
          child: AnimatedColumn(
            children: [
              Visibility(
                visible: (widget.isUpdatingMapLocation??false) == false,
                child: GestureDetector(
                  onTap: (){
                    triggerHapticFeedback();
                    Get.to(() => OnboardingLocationScreen(
                      isEditProfile: true,
                      lat: widget.lat,
                      long: widget.long,
                      isUpdatingMapLocation: widget.isUpdatingMapLocation,
                    ));
                  },
                  child: BaseContainer(
                    leftPadding: 20,
                    rightPadding: 20,
                    topPadding: 10,
                    bottomPadding: 13,
                    bottomMargin: 14,
                    child: ManualAddressListTile(
                      title: widget.fullAddress?.split(",").first??"",
                      subtitle: widget.fullAddress?.replaceAll("${widget.fullAddress?.split(",").first}, ", "")??"",
                    ),
                  ),
                ),
              ),
              BaseContainer(
                leftPadding: 20,
                rightPadding: 20,
                topPadding: 10,
                bottomPadding: 13,
                child: AnimatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  rightPadding: 0,
                  leftPadding: 0,
                  children: [
                    BaseTextField(
                      topMargin: 16,
                      controller: controller.houseNoController,
                      labelText: 'House / Flat / Block Number',
                      hintText: 'Enter house / flat / block number',
                      textInputType: TextInputType.name,
                    ),
                    BaseTextField(
                      topMargin: 16,
                      controller: controller.apartmentController,
                      labelText: 'Apartment / Road / Area (Optional)',
                      hintText: 'Enter apartment / road /area',
                      textInputType: TextInputType.name,
                    ),
                    BaseTextField(
                      topMargin: 16,
                      controller: controller.landmarkController,
                      labelText: 'Description (Optional)',
                      hintText: 'e.g. Landmark etc',
                      textInputType: TextInputType.name,
                    ),
                    /*const BaseText(
                      topMargin: 14,
                      value: "SAVE AS",
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      bottomMargin: 8,
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      children: controller.addressTypeList.map((val) {
                        return Obx(()=>CustomRadioButton(
                            title: val,
                            isSelected: controller.selectedAddressType.value == val,
                            onTap: () {
                              triggerHapticFeedback();
                              controller.selectedAddressType.value = val;
                            },
                          ),
                        );
                      }).toList(),
                    ),*/
                    BaseButton(
                      title: (widget.addressId??"").isEmpty ? "Submit" : "Update",
                      topMargin: 5,
                      onPressed: (){
                        if (controller.houseNoController.text.trim().isEmpty) {
                          showSnackBar(message: "Please Enter House / Flat / Block Number");
                        }/*else if (controller.apartmentController.text.trim().isEmpty) {
                          showSnackBar(subtitle: "Please Enter Apartment / Road / Area");
                        }*/ /*else if (controller.landmarkController.text.trim().isEmpty) {
                          showSnackBar(message: "Please Enter Description");
                        }*/else{
                          controller.saveAddress(
                            addressId: widget.addressId??"",
                            lat: widget.lat??0,
                            lng: widget.long??0,
                            fullAddress: widget.fullAddress??"",
                            showSavedAddress: widget.showSavedAddress??false,
                          );
                        }
                      },
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
