import 'dart:io';

import 'package:binbeardriver/ui/base_components/base_form_field_validator_icon.dart';
import 'package:binbeardriver/ui/onboardings/login/login_screen.dart';
import 'package:binbeardriver/ui/onboardings/splash/controller/base_controller.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:binbeardriver/ui/base_components/animated_column.dart';
import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_button.dart';
import 'package:binbeardriver/ui/base_components/base_container.dart';
import 'package:binbeardriver/ui/base_components/base_outlined_button.dart';
import 'package:binbeardriver/ui/base_components/base_scaffold_background.dart';
import 'package:binbeardriver/ui/base_components/base_text.dart';
import 'package:binbeardriver/ui/base_components/base_textfield.dart';
import 'package:binbeardriver/ui/onboardings/signup/controller/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpController controller = Get.put(SignUpController());
  BaseController baseController = Get.find<BaseController>();

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const BaseAppBar(),
        body: SingleChildScrollView(
          child: AnimatedColumn(
            children: [
              const SizedBox(height: 52),
              Hero(
                tag: "splash_tag",
                child: SvgPicture.asset(
                  BaseAssets.appLogoWithName,
                  width: 90,
                ),
              ),
              BaseContainer(
                topMargin: 26,
                child: GetBuilder<SignUpController>(
                  builder: (SignUpController controller) {
                    return AnimatedColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const BaseText(
                            value: "Let’s Get Started!",
                            textAlign: TextAlign.center,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: BaseColors.primaryColor),
                        const BaseText(
                          topMargin: 4,
                          value:
                              "Create an account by filling in the\ninformation below",
                          fontWeight: FontWeight.w700,
                        ),
                        BaseTextField(
                          topMargin: 16,
                          controller: controller.nameController,
                          labelText: 'Name',
                          hintText: 'Enter Full Name',
                          textInputType: TextInputType.name,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 13),
                            child: SvgPicture.asset(BaseAssets.icPerson),
                          ),
                          suffixIcon: BaseFormFieldValidatorIcon(
                            textEditingController: controller.nameController,
                            failedOn: controller.nameController.text.length < 2,
                          ),
                          onChanged: (val) {
                            controller.update();
                          },
                        ),
                        BaseTextField(
                          topMargin: 16,
                          controller: controller.businessNameController,
                          labelText: 'Business Name',
                          hintText: 'Enter Business Name',
                          textInputType: TextInputType.name,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 13),
                            child: SvgPicture.asset(BaseAssets.icBusiness),
                          ),
                          suffixIcon: BaseFormFieldValidatorIcon(
                            textEditingController:
                                controller.businessNameController,
                            failedOn:
                                controller.businessNameController.text.length <
                                    2,
                          ),
                          onChanged: (val) {
                            controller.update();
                          },
                        ),
                        BaseTextField(
                          topMargin: 12,
                          controller: controller.emailController,
                          labelText: 'Email Address',
                          hintText: 'Email Address',
                          textInputType: TextInputType.emailAddress,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 13),
                            child: SvgPicture.asset(BaseAssets.icEmail),
                          ),
                          suffixIcon: BaseFormFieldValidatorIcon(
                            textEditingController: controller.emailController,
                            failedOn: !GetUtils.isEmail(
                                controller.emailController.text),
                          ),
                          onChanged: (val) {
                            controller.update();
                          },
                        ),
                        BaseTextField(
                          topMargin: 12,
                          controller: controller.mobileController,
                          labelText: 'Enter Mobile Number',
                          hintText: 'Mobile Number',
                          textInputFormatter: [usPhoneMask],
                          textInputType: TextInputType.phone,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 13),
                            child: SvgPicture.asset(BaseAssets.icPhone),
                          ),
                          suffixIcon: BaseFormFieldValidatorIcon(
                            textEditingController: controller.mobileController,
                            failedOn:
                                controller.mobileController.text.length < 14,
                          ),
                          onChanged: (val) {
                            controller.update();
                          },
                        ),
                        BaseTextField(
                          topMargin: 14,
                          controller: controller.passwordController,
                          obscureText: controller.obscurePassword,
                          labelText: 'Password',
                          hintText: 'Enter Password',
                          textInputType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 13),
                            child: SvgPicture.asset(BaseAssets.icLock),
                          ),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    triggerHapticFeedback();
                                    controller.obscurePassword =
                                        !(controller.obscurePassword);
                                    controller.update();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: controller.obscurePassword
                                        ? const Icon(Icons.visibility_off,
                                            size: 24)
                                        : const Icon(Icons.visibility,
                                            size: 24),
                                  )),
                              BaseFormFieldValidatorIcon(
                                leftMargin: 6,
                                textEditingController:
                                    controller.passwordController,
                                failedOn:
                                    controller.passwordController.text.length <
                                        8,
                              ),
                            ],
                          ),
                          onChanged: (val) {
                            controller.update();
                          },
                        ),
                        BaseTextField(
                          topMargin: 14,
                          bottomMargin: 20,
                          obscureText: controller.obscureConfirmPassword,
                          controller: controller.confirmPasswordController,
                          labelText: 'Confirm password',
                          hintText: 'Enter Password Again',
                          textInputType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 13),
                            child: SvgPicture.asset(BaseAssets.icLock),
                          ),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  triggerHapticFeedback();
                                  controller.obscureConfirmPassword =
                                      !(controller.obscureConfirmPassword);
                                  controller.update();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: controller.obscureConfirmPassword
                                      ? const Icon(Icons.visibility_off,
                                          size: 24)
                                      : const Icon(Icons.visibility, size: 24),
                                ),
                              ),
                              BaseFormFieldValidatorIcon(
                                leftMargin: 6,
                                textEditingController:
                                    controller.confirmPasswordController,
                                failedOn: controller
                                            .confirmPasswordController.text !=
                                        controller.passwordController.text ||
                                    controller.passwordController.text.length <
                                        8,
                              ),
                            ],
                          ),
                          onChanged: (val) {
                            controller.update();
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            showMediaPicker().then((value) {
                              if ((value?.path ?? "").isNotEmpty) {
                                controller.pickedFile = File(value?.path ?? "");
                                setState(() {});
                              }
                            });
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            dashPattern: const [3, 2],
                            color: const Color(0xffC2C2C2),
                            radius: const Radius.circular(12),
                            child: Container(
                              height: 94,
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: controller.pickedFile?.path.isNotEmpty ??
                                      false
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  controller.pickedFile ?? File(""),
                                  width: double.maxFinite,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                              )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            BaseAssets.icUploadDocuments),
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
                          topMargin: 20,
                          title: "Add Location",
                          btnWidth: double.infinity,
                          btnHeight: primaryButtonHeight,
                          borderRadius: 14,
                          fontSize: 16,
                          onPressed: () {
                            if (controller.nameController.text.trim().isEmpty) {
                              showSnackBar(message: "Please Enter Full Name");
                            } else if (controller.nameController.text
                                    .trim()
                                    .length <
                                2) {
                              showSnackBar(message: "Please Enter Valid Name");
                            } else if (controller.businessNameController.text
                                .trim()
                                .isEmpty) {
                              showSnackBar(
                                  message: "Please Enter Business Name");
                            } else if (controller.businessNameController.text
                                    .trim()
                                    .length <
                                2) {
                              showSnackBar(
                                  message: "Please Enter Valid Business Name");
                            } else if (controller.emailController.text
                                .trim()
                                .isEmpty) {
                              showSnackBar(message: "Please Enter Email");
                            } else if (!GetUtils.isEmail(
                                controller.emailController.text.trim())) {
                              showSnackBar(message: "Please Enter Valid Email");
                            } else if (controller.mobileController.text
                                .trim()
                                .isEmpty) {
                              showSnackBar(
                                  message: "Please Enter Mobile Number");
                            } else if (controller.mobileController.text
                                    .trim()
                                    .length <
                                14) {
                              showSnackBar(
                                  message: "Please Enter Valid Mobile Number");
                            } else if (controller.passwordController.text
                                .trim()
                                .isEmpty) {
                              showSnackBar(message: "Please Enter Password");
                            } else if (controller.passwordController.text
                                    .trim()
                                    .length <
                                8) {
                              showSnackBar(
                                  message:
                                      "Password Length Can't Be Less Than 8");
                            } else if (controller.confirmPasswordController.text
                                .trim()
                                .isEmpty) {
                              showSnackBar(
                                  message: "Please Enter Confirm Password");
                            } else if (controller.confirmPasswordController.text
                                    .trim() !=
                                controller.passwordController.text.trim()) {
                              showSnackBar(
                                  message:
                                      "Confirm Password Is Not Matching, Please Check");
                            } else {
                              baseController.isAddressTappedOnSignUp.value =
                                  true;
                              controller.callSignUpApi();
                            }
                            // Get.to(() => OnboardingLocationScreen());
                          },
                        ),
                        BaseButton(
                          topMargin: 20,
                          title: "Sign up",
                          onPressed: () {
                            if (controller.nameController.text.trim().isEmpty) {
                              showSnackBar(message: "Please Enter Full Name");
                            } else if (controller.nameController.text
                                    .trim()
                                    .length <
                                2) {
                              showSnackBar(message: "Please Enter Valid Name");
                            } else if (controller.businessNameController.text
                                .trim()
                                .isEmpty) {
                              showSnackBar(
                                  message: "Please Enter Business Name");
                            } else if (controller.businessNameController.text
                                    .trim()
                                    .length <
                                2) {
                              showSnackBar(
                                  message: "Please Enter Valid Business Name");
                            } else if (controller.emailController.text
                                .trim()
                                .isEmpty) {
                              showSnackBar(message: "Please Enter Email");
                            } else if (!GetUtils.isEmail(
                                controller.emailController.text.trim())) {
                              showSnackBar(message: "Please Enter Valid Email");
                            } else if (controller.mobileController.text
                                .trim()
                                .isEmpty) {
                              showSnackBar(
                                  message: "Please Enter Mobile Number");
                            } else if (controller.mobileController.text
                                    .trim()
                                    .length <
                                14) {
                              showSnackBar(
                                  message: "Please Enter Valid Mobile Number");
                            } else if (controller.passwordController.text
                                .trim()
                                .isEmpty) {
                              showSnackBar(message: "Please Enter Password");
                            } else if (controller.passwordController.text
                                    .trim()
                                    .length <
                                8) {
                              showSnackBar(
                                  message:
                                      "Password Length Can't Be Less Than 8");
                            } else if (controller.confirmPasswordController.text
                                .trim()
                                .isEmpty) {
                              showSnackBar(
                                  message: "Please Enter Confirm Password");
                            } else if (controller.confirmPasswordController.text
                                    .trim() !=
                                controller.passwordController.text.trim()) {
                              showSnackBar(
                                  message:
                                      "Confirm Password Is Not Matching, Please Check");
                            } else {
                              controller.callSignUpApi();
                            }
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            triggerHapticFeedback();
                            Get.back();
                            Get.to(const LoginScreen());
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BaseText(
                                topMargin: 25,
                                value: "Already have an account?",
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                rightMargin: 2.5,
                              ),
                              BaseText(
                                topMargin: 25,
                                leftMargin: 2.5,
                                value: "Login",
                                fontSize: 13,
                                color: BaseColors.secondaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
