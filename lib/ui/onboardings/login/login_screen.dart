import 'package:binbeardriver/ui/driver/jobs_screen/jobs_screen.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/storage_keys.dart';
import '../../base_components/animated_column.dart';
import '../../base_components/base_button.dart';
import '../../base_components/base_container.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../base_components/base_text_button.dart';
import '../../base_components/base_textfield.dart';
import '../../base_components/signup_user_type_selection.dart';
import '../../dashboard_module/dashboard_screen/dashboard_screen.dart';
import '../forgot_password/forgot_password_screen.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 70),
            Hero(
              tag: "splash_tag",
              child: SvgPicture.asset(
                BaseAssets.appLogoWithName,
                width: 90,
              ),
            ),
            Expanded(
              child: BaseContainer(
                topMargin: 26,
                bottomMargin: horizontalScreenPadding+6,
                rightMargin: horizontalScreenPadding,
                leftMargin: horizontalScreenPadding,
                child: SingleChildScrollView(
                  child: AnimatedColumn(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const BaseText(
                          value: "Welcome to",
                          textAlign: TextAlign.center,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 1.5
                      ),
                      Image.asset(BaseAssets.binBearTextLogo, width: 70,),
                      const SizedBox(height: 60),
                      Obx(()=>Row(
                          children: [
                            Expanded(
                              child: SignUpUserTypeSelection(
                                title: 'Service\nProvider',
                                imageUrl: BaseAssets.icServiceProvider,
                                isChecked: controller.selectedUserType.value == "Service Provider",
                                onTap: () {
                                  triggerHapticFeedback();
                                  controller.selectedUserType.value = "Service Provider";
                                  controller.box.write(StorageKeys.isUserDriver, false);
                                },
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: SignUpUserTypeSelection(
                                title: 'BinBears',
                                imageUrl: BaseAssets.icBinBears,
                                isChecked: controller.selectedUserType.value == "BinBears",
                                onTap: () {
                                  triggerHapticFeedback();
                                  controller.selectedUserType.value = "BinBears";
                                  controller.box.write(StorageKeys.isUserDriver, true);
                                },
                              ),
                            ),
                          ],
                        )),
                      BaseTextField(
                        topMargin: 25,
                        controller: TextEditingController(),
                        hintText: 'Email Address',
                        labelText: 'Email Address',
                        textInputType: TextInputType.emailAddress,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 13),
                          child: SvgPicture.asset(BaseAssets.icEmail),
                        ),
                      ),
                      BaseTextField(
                        topMargin: 14,
                        controller: TextEditingController(),
                        labelText: 'Password',
                        hintText: 'Enter Password',
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
                      BaseButton(
                        topMargin: 24,
                        title: "Login",
                        onPressed: (){
                          if (controller.box.read(StorageKeys.isUserDriver)) {
                            Get.offAll(() => const JobsScreen());
                          }else{
                            Get.offAll(() => const DashBoardScreen());
                          }
                        },
                      ),
                      BaseTextButton(
                        title: "Forgot Password?",
                        bottomMargin: 15,
                        onPressed: (){
                          Get.to(const ForgotPasswordScreen());
                        },
                      ),
                      Obx(()=>Visibility(
                          visible: controller.selectedUserType.value == "Service Provider",
                          child: GestureDetector(
                            onTap: (){
                              triggerHapticFeedback();
                              Get.back();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BaseText(
                                  value: "Don’t have an account?",
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  rightMargin: 2.5,
                                ),
                                BaseText(
                                  leftMargin: 2.5,
                                  value: "Sign up",
                                  fontSize: 13,
                                  color: BaseColors.secondaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ),
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
