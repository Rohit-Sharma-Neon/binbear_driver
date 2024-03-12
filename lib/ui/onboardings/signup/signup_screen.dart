import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../base_components/animated_column.dart';
import '../../base_components/base_app_bar.dart';
import '../../base_components/base_button.dart';
import '../../base_components/base_container.dart';
import '../../base_components/base_outlined_button.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../base_components/base_textfield.dart';
import '../location/onboarding_location_screen.dart';
import '../otp_validation/otp_screen.dart';
import 'controller/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  SignUpController controller = Get.put(SignUpController());

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
                child: AnimatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BaseText(
                        value: "Let’s Get Started!",
                        textAlign: TextAlign.center, 
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: BaseColors.primaryColor
                    ),
                    const BaseText(
                      topMargin: 4,
                      value: "Create an account by filling in the\ninformation below",
                      fontWeight: FontWeight.w700,
                    ),
                    BaseTextField(
                      topMargin: 16,
                      controller: TextEditingController(),
                      labelText: 'Name',
                      hintText: 'Enter Full Name',
                      textInputType: TextInputType.name,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: SvgPicture.asset(BaseAssets.icPerson),
                      ),
                    ),
                    BaseTextField(
                      topMargin: 16,
                      controller: TextEditingController(),
                      labelText: 'Business Name',
                      hintText: 'Enter Business Name',
                      textInputType: TextInputType.name,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: SvgPicture.asset(BaseAssets.icBusiness),
                      ),
                    ),
                    BaseTextField(
                      topMargin: 12,
                      controller: TextEditingController(),
                      labelText: 'Email Address',
                      hintText: 'Email Address',
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: SvgPicture.asset(BaseAssets.icEmail),
                      ),
                    ),
                    BaseTextField(
                      topMargin: 12,
                      controller: TextEditingController(),
                      labelText: 'Enter Mobile Number',
                      hintText: 'Mobile Number',
                      textInputType: TextInputType.phone,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: SvgPicture.asset(BaseAssets.icPhone),
                      ),
                    ),
                    BaseTextField(
                      topMargin: 14,
                      controller: TextEditingController(),
                      labelText: 'Password',
                      hintText: 'Enter Password',
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: SvgPicture.asset(BaseAssets.icLock),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: SvgPicture.asset(BaseAssets.icEyeCrossed),
                      ),
                    ),
                    BaseTextField(
                      topMargin: 14,
                      bottomMargin: 20,
                      controller: TextEditingController(),
                      labelText: 'Confirm password',
                      hintText: 'Enter Password Again',
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: SvgPicture.asset(BaseAssets.icLock),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: SvgPicture.asset(BaseAssets.icEyeCrossed),
                      ),
                    ),
                    DottedBorder(
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
                    BaseOutlinedButton(
                      topMargin: 20,
                      title: "Add Location",
                      btnWidth: double.infinity,
                      btnHeight: primaryButtonHeight,
                      borderRadius: 14,
                      fontSize: 16,
                      onPressed: (){
                        Get.to(() => OnboardingLocationScreen());
                      },
                    ),
                    BaseButton(
                      topMargin: 20,
                      title: "Sign up",
                      onPressed: (){
                        Get.to(()=> const OtpScreen());
                      },
                    ),
                    GestureDetector(
                      onTap: (){
                        triggerHapticFeedback();
                        Get.back();
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
