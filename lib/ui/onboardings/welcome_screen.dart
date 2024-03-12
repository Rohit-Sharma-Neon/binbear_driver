import '../base_components/animated_column.dart';
import '../base_components/base_button.dart';
import '../base_components/base_container.dart';
import '../base_components/base_scaffold_background.dart';
import '../base_components/base_text.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'login/login_screen.dart';
import 'signup/signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: SingleChildScrollView(
          child: AnimatedColumn(
            children: [
              const SizedBox(height: 70),
              Hero(
                tag: "splash_tag",
                child: SvgPicture.asset(
                  BaseAssets.appLogoWithName,
                  width: 90,
                ),
              ),
              BaseContainer(
                topMargin: 26,
                bottomMargin: 40,
                child: AnimatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BaseText(
                        value: "Thank You For Your Interest.",
                        textAlign: TextAlign.center,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1.3
                    ),
                    const BaseText(
                        topMargin: 45,
                        value: "The Business Does\nNot Run Without\nYou!",
                        textAlign: TextAlign.center,
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        height: 1.3
                    ),
                    BaseButton(
                      topMargin: 55,
                      title: "Become A Binbear",
                      onPressed: (){
                        Get.to(() => const SignUpScreen());
                      },
                      bottomMargin: 18,
                    ),
                    BaseText(
                      topMargin: 7,
                      value: "Already have and account?",
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      onTap: (){
                        Get.to(() => const LoginScreen());
                      },
                    ),
                    BaseText(
                      value: "Log in",
                      fontSize: 14,
                      color: BaseColors.secondaryColor,
                      fontWeight: FontWeight.w500,
                      onTap: (){
                        Get.to(const LoginScreen());
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
