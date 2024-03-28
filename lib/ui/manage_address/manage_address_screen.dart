import 'package:binbeardriver/ui/base_components/custom_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/base_functions.dart';
import '../base_components/animated_column.dart';
import '../base_components/base_app_bar.dart';
import '../base_components/base_button.dart';
import '../base_components/base_container.dart';
import '../base_components/base_scaffold_background.dart';
import '../base_components/base_text.dart';
import '../base_components/base_textfield.dart';
import '../manual_address/components/manual_address_list_tile.dart';
import 'controller/manage_address_controller.dart';

class ManageAddressScreen extends StatefulWidget {
  final double? lat, long;
  final String? fullAddress;
  final bool? showSavedAddress;
  const ManageAddressScreen({super.key, this.lat, this.long, this.fullAddress, this.showSavedAddress});
  @override
  State<ManageAddressScreen> createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  ManageAddressController controller = Get.put(ManageAddressController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        appBar: const BaseAppBar(),
        body: SingleChildScrollView(
          child: AnimatedColumn(
            children: [
              BaseContainer(
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
                      labelText: 'Description',
                      hintText: 'e.g. Landmark etc',
                      textInputType: TextInputType.name,
                    ),
                    const BaseText(
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
                    ),
                    BaseButton(
                      title: "Submit",
                      topMargin: 5,
                      onPressed: (){
                        if (controller.houseNoController.text.trim().isEmpty) {
                          showSnackBar(subtitle: "Please Enter House / Flat / Block Number");
                        }/*else if (controller.apartmentController.text.trim().isEmpty) {
                          showSnackBar(subtitle: "Please Enter Apartment / Road / Area");
                        }*/else if (controller.landmarkController.text.trim().isEmpty) {
                          showSnackBar(subtitle: "Please Enter Description");
                        }else{
                          controller.saveAddress(
                            lat: widget.lat??0,
                            lng: widget.long??0,
                            fullAddress: widget.fullAddress??"",
                            showSavedAddress: widget.showSavedAddress??false,
                          );
                        }
                      },
                    )
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
