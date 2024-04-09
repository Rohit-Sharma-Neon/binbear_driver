import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:binbeardriver/ui/base_components/animated_column.dart';
import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_button.dart';
import 'package:binbeardriver/ui/base_components/base_container.dart';
import 'package:binbeardriver/ui/base_components/base_scaffold_background.dart';
import 'package:binbeardriver/ui/base_components/base_text.dart';
import 'package:binbeardriver/ui/base_components/base_textfield.dart';
import 'package:binbeardriver/ui/onboardings/forgot_password/controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgotPasswordController controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        appBar: const BaseAppBar(),
        body: SingleChildScrollView(
          child: AnimatedColumn(
            children: [
              BaseContainer(
                topMargin: 10,
                child: AnimatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BaseText(
                      value: "Forget Password?",
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 10),
                    const BaseText(
                      value:
                          "Please enter your registered email address to send otp for reset password",
                      textAlign: TextAlign.center,
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 60),
                    BaseTextField(
                      controller: controller.emailController,
                      labelText: 'Email Address',
                      hintText: 'Enter Email Address',
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: SvgPicture.asset(BaseAssets.icEmail),
                      ),
                    ),
                    BaseButton(
                      topMargin: 24,
                      title: "Send",
                      onPressed: () {
                        if (!GetUtils.isEmail(
                            controller.emailController.text)) {
                          showSnackBar(message: "Please Enter Valid Email");
                        } else {
                          controller.sendOtpForgotPassword();
                        }
                        // Get.off(() => const OtpScreen());
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
