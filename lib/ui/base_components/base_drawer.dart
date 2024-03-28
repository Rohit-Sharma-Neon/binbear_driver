import 'package:binbeardriver/ui/about_app/about_app_screen.dart';
import 'package:binbeardriver/ui/contact_us/contact_us_screen.dart';
import 'package:binbeardriver/ui/help_&_support/help_&_support_screen.dart';
import 'package:binbeardriver/ui/onboardings/welcome_screen.dart';
import 'package:binbeardriver/ui/transactions_screen/transactions_screen.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/get_storage.dart';
import 'package:binbeardriver/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../dashboard_module/dashboard_screen/controller/dashboard_controller.dart';
import 'base_text.dart';
import 'base_text_button.dart';

class BaseDrawer extends StatelessWidget {
  const BaseDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width/1.3,
      height: double.infinity,
      padding: const EdgeInsets.only(top: 35, bottom: 50),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          GetStorage().read(StorageKeys.isUserDriver)??false ?
          Container(
              height: 100,
              width: 100,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(BaseAssets.icBinBears)) :
          ClipRRect(
            borderRadius: BorderRadius.circular(90),
            child: Image.asset("assets/delete/dummy_profile.jpeg", width: 100, height: 100, fit: BoxFit.fill),
          ),
          const BaseText(
            topMargin: 15,
            value: "Rohit Sharma",
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          const Divider(thickness: 0.6, color: Colors.grey, height: 35),
          drawerListTiles(
            title: 'Our Story',
            onTap: () {},
          ),
          drawerListTiles(
            title: 'Contact Us',
            onTap: () {
              Get.to(() => const ContactUsScreen());
            },
          ),
          drawerListTiles(
            title: 'Privacy Policy',
            onTap: () {
              Get.to(() => const AboutAppScreen(type: "Privacy Policy"));
            },
          ),
          drawerListTiles(
            title: 'Terms & Conditions',
            onTap: () {
              Get.to(() => const AboutAppScreen(type: "Terms & Conditions"));
            },
          ),
          drawerListTiles(
            title: 'Help & Support',
            onTap: () {},
          ),
          drawerListTiles(
            title: 'Transactions',
            onTap: () {
              Get.to(() => const TransactionsScreen());
            },
          ),
          drawerListTiles(
            title: 'About Us',
            onTap: () {
              Get.to(() => const AboutAppScreen(type: "About Us"));
            },
          ),
          Visibility(
            visible: !(GetStorage().read(StorageKeys.isUserDriver)??false),
            child: drawerListTiles(
              title: 'Help & Support',
              onTap: () {
                Get.to(() => const HelpSupportScreen());
              },
            ),
          ),
          const Spacer(),
          drawerListTiles(
            title: 'Log Out',
            onTap: () {
              BaseStorage.remove(StorageKeys.apiToken);
              BaseStorage.remove(StorageKeys.userName);
              BaseStorage.remove(StorageKeys.isUserDriver);
              BaseStorage.remove(StorageKeys.profilePhoto);
              Get.offAll(() => const WelcomeScreen());
            },
          ),
        ],
      ),
    );
  }

  Widget drawerListTiles({required String title, required void Function()? onTap}){
    return BaseTextButton(
      btnHeight: 55,
      borderRadius: 0,
      btnPadding: const EdgeInsets.only(left: 0),
      onPressed: (){
        Get.find<DashboardController>().scaffoldKey.currentState?.closeDrawer();
        onTap!();
      },
      child: Row(
        children: [
          const SizedBox(width: 18),
          SvgPicture.asset(BaseAssets.icArrowRight),
          BaseText(
            leftMargin: 18,
            value: title,
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
