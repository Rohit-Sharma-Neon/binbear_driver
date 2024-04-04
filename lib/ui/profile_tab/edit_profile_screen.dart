import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:binbeardriver/ui/base_components/base_outlined_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:binbeardriver/ui/base_components/animated_column.dart';
import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_button.dart';
import 'package:binbeardriver/ui/base_components/base_container.dart';
import 'package:binbeardriver/ui/base_components/base_dummy_profile.dart';
import 'package:binbeardriver/ui/base_components/base_form_field_validator_icon.dart';
import 'package:binbeardriver/ui/base_components/base_radio_button.dart';
import 'package:binbeardriver/ui/base_components/base_scaffold_background.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:binbeardriver/ui/base_components/base_text.dart';
import 'package:binbeardriver/ui/base_components/base_textfield.dart';
import 'package:binbeardriver/ui/manage_address/manage_address_screen.dart';
import 'package:binbeardriver/ui/profile_tab/controller/profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  ProfileController controller = Get.find<ProfileController>();
  @override
  void initState() {
    super.initState();
    controller.setData();
  }
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const BaseAppBar(showDrawerIcon: false,),
        body: Column(
          children: [
            const BaseText(
              topMargin: 70,
              value: "Edit Profile",
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            const BaseText(
              topMargin: 5,
              value: "Lorem ipsum is a dummy text",
              fontSize: 14,
              color: Color(0xffFBE6D3),
              fontWeight: FontWeight.w400,
            ),
            Expanded(
              child: BaseContainer(
                topMargin: 15,
                bottomMargin: 18,
                rightMargin: horizontalScreenPadding,
                leftMargin: horizontalScreenPadding,
                child: SingleChildScrollView(
                  child: AnimatedColumn(
                    children: [
                      GestureDetector(
                        onTap: (){
                          showMediaPicker(isCropEnabled: true).then((value) {
                            if ((value?.path??"").isNotEmpty) {
                              controller.selectedImage?.value = value;
                            }
                          });
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Hero(
                              tag: "profile_image",
                              child: Obx(
                                    () {
                                  if ((controller.selectedImage?.value?.path ?? "").isNotEmpty) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.file(
                                        controller.selectedImage?.value ?? File(""),width: 100,
                                        height: 100,fit: BoxFit.cover,),
                                    );
                                  } else if ((controller.profileData?.value?.profile?.toString() ?? "").isNotEmpty) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        controller.profileData?.value?.profile
                                            ?.toString() ?? "",
                                        width: 100,
                                        height: 100,fit: BoxFit.cover,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if(loadingProgress == null) {
                                            return child;
                                          }
                                          return const CircularProgressIndicator();
                                          }
                                      ),
                                    );
                                  } else {
                                    return const BaseDummyProfile(
                                        overflowHeight: 140,
                                        overflowWidth: 190,
                                        topMargin: 10);
                                  }
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: ZoomIn(
                                duration: const Duration(milliseconds: 700),
                                child: Container(
                                  padding: const EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: BaseColors.primaryColor,
                                  ),
                                  child: const Icon(Icons.edit_sharp,
                                      color: Colors.white, size: 19),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      GetBuilder<ProfileController>(
                        builder: (ProfileController controller) {
                          return BaseTextField(
                            topMargin: 30,
                            controller: controller.nameController,
                            labelText: "Name",
                            hintText: "Enter Full Name",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: SvgPicture.asset(BaseAssets.icPerson),
                            ),
                            suffixIcon: BaseFormFieldValidatorIcon(
                              textEditingController: controller.nameController,
                              failedOn:
                              controller.nameController.text.length < 2,
                            ),
                            onChanged: (val) {
                              controller.update();
                            },
                          );
                        },
                      ),
                      GetBuilder<ProfileController>(
                        builder: (ProfileController controller) {
                          return IgnorePointer(
                            child: BaseTextField(
                              topMargin: 15,
                              controller: controller.emailController,
                              labelText: "Email Address",
                              hintText: "Email Address",
                              // readOnly: true,
                              onTap: () {},
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: SvgPicture.asset(BaseAssets.icEmail),
                              ),
                              suffixIcon: BaseFormFieldValidatorIcon(
                                textEditingController:
                                controller.emailController,
                                failedOn: !GetUtils.isEmail(
                                    controller.emailController.text),
                              ),
                              onChanged: (val) {
                                controller.update();
                              },
                            ),
                          );
                        },
                      ),
                      GetBuilder<ProfileController>(
                        builder: (ProfileController controller) {
                          return IgnorePointer(
                            child: BaseTextField(
                              topMargin: 15,
                              controller: controller.mobileController,
                              labelText: "Mobile Number",
                              hintText: "Enter Mobile Number",
                              textInputFormatter: [usPhoneMask],
                              textInputType: TextInputType.phone,
                              // readOnly: true,
                              onTap: () {},
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(BaseAssets.icPhone),
                                    const BaseText(
                                      leftMargin: 7,
                                      value: "+1",
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                              suffixIcon: BaseFormFieldValidatorIcon(
                                textEditingController:
                                controller.mobileController,
                                failedOn:
                                controller.mobileController.text.length <
                                    14,
                              ),
                              onChanged: (val) {
                                controller.update();
                              },
                            ),
                          );
                        },
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: BaseText(
                          topMargin: 15,
                          bottomMargin: 11,
                          value: "Gender",
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Obx(()=>Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BaseRadioButton(
                              value: "Male",
                              selectedValue: controller.selectedGender.value,
                              onTap: () {
                                controller.selectedGender.value = "Male";
                              },
                            ),
                            BaseRadioButton(
                              value: "Female",
                              selectedValue: controller.selectedGender.value,
                              onTap: () {
                                controller.selectedGender.value = "Female";
                              },
                            ),
                            const SizedBox(width: 70),
                          ],
                        ),
                      ),
                      const SizedBox(height: 34),
                  GestureDetector(
                    onTap: (){
                      FocusManager.instance.primaryFocus?.unfocus();
                      showMediaPicker().then((value) {
                        if ((value?.path??"").isNotEmpty) {
                          controller.pickedFile = File(value?.path??"");
                        }
                      });
                    },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          dashPattern: const [3,2],
                          color: const Color(0xffC2C2C2),
                          radius: const Radius.circular(12),
                          child: Container(
                            height: 94,
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(BaseAssets.icUploadDocuments),
                                const BaseText(
                                  topMargin: 12,
                                  value: "Upload Valid ID proof",
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      BaseOutlinedButton(
                        topMargin: 30,
                        btnHeight: 60,
                        btnRightPadding: 20,
                        borderRadius: 13,
                        onPressed: () {
                          Get.to(const ManageAddressScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const BaseText(
                              value: "3d, Avenue Road",
                              fontSize: 14,
                              color: BaseColors.secondaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                            SvgPicture.asset(BaseAssets.icArrowRight)
                          ],
                        ),
                      ),
                      BaseButton(
                        topMargin: 20,
                        btnHeight: 60,
                        title: "Save",
                        onPressed: () {
                          if (controller.nameController.text.trim().isEmpty) {
                            showSnackBar(message: "Please Enter Full Name");
                          } else if (controller.nameController.text.trim().length < 2) {
                            showSnackBar(message: "Please Enter Valid Name");
                          } else {
                            controller.updateProfile();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
