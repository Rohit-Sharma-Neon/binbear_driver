import 'package:animate_do/animate_do.dart';
import 'package:binbeardriver/ui/driver/jobs_screen/controller/jobs_controller.dart';
import 'package:binbeardriver/ui/home_tab/controller/home_tab_controller.dart';
import 'package:binbeardriver/ui/onboardings/splash/controller/base_controller.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:binbeardriver/utils/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:binbeardriver/utils/storage_keys.dart';
import 'package:binbeardriver/ui/dashboard_module/dashboard_screen/controller/dashboard_controller.dart';
import 'package:binbeardriver/ui/notification/notification_screen.dart';
import 'package:binbeardriver/ui/base_components/base_text.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? contentColor;
  final bool? showNotification, showDrawerIcon, showSwitchButton, showBackButton;
  final Function()? onBackPressed;
  final Widget? bottomChild;
  final double? bottomWidgetHeight, titleSize, titleSpacing;
  final FontWeight? fontWeight;
  const BaseAppBar({super.key, this.title, this.onBackPressed, this.showNotification, this.showDrawerIcon, this.bottomChild, this.bottomWidgetHeight, this.contentColor, this.titleSize, this.fontWeight, this.showSwitchButton, this.titleSpacing, this.showBackButton});

  @override
  Widget build(BuildContext context) {
    BaseController baseController = Get.find<BaseController>();
    return AppBar(
      title: FadeInDown(
          duration: const Duration(milliseconds: 400),
          child: BaseText(value: title??"", color: (showDrawerIcon??false) ? Colors.white : contentColor, fontSize: (showDrawerIcon??false) ? 18 : titleSize, fontWeight: (showDrawerIcon??false) ? FontWeight.w500 : fontWeight,)),
      backgroundColor: Colors.transparent,
      titleSpacing: (showDrawerIcon??false) ? 0 : titleSpacing,
      elevation: 0.0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      bottom: PreferredSize(preferredSize: Size.fromHeight(bottomWidgetHeight??0),
      child: bottomChild ?? const SizedBox.shrink()),
      leading: FadeInDown(
        duration: const Duration(milliseconds: 400),
        child: (showDrawerIcon??false)
        ///   Drawer Icon
            ? GestureDetector(onTap: (){
              triggerHapticFeedback();
          if (BaseStorage.read(StorageKeys.isUserDriver)??false) {
            Get.find<JobsController>().jobsScaffoldKey.currentState?.openDrawer();
          }else{
            Get.find<DashboardController>().scaffoldKey.currentState?.openDrawer();
          }
        }, child: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(BaseAssets.icDrawer),
            ),
        )
        ///   Back Icon
            : Visibility(
          visible: showBackButton??true,
          child: GestureDetector(onTap: onBackPressed ?? (){
            triggerHapticFeedback();
            Get.back();
          },child: Icon(Icons.arrow_back_sharp,
              color: contentColor??Colors.white,size: 30)),
        ),
      ),
      actions: [
        Visibility(
          visible: showSwitchButton??false,
          child: FadeInDown(
            duration: const Duration(milliseconds: 400),
            child: Transform.scale(
              scale: 0.75,
              child: Obx(()=> Switch(
                  value: baseController.isAvailable.value == "1" ? true : false,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  inactiveThumbColor: Colors.black,
                  inactiveTrackColor: Colors.white,
                  activeColor: Colors.white,
                  activeTrackColor: Colors.white,
                  trackOutlineWidth: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
                    return 1.6;
                  }),
                  trackOutlineColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    return Colors.black;
                  }),
                  thumbColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    return Colors.black;
                  },
                  ),
                  onChanged: (val){
                    triggerHapticFeedback();
                    baseController.setAvailabilityApi(
                          baseController.isAvailable.value == "1" ? "0" : "1");
                  },
                ),
              ),
            )
          ),
        ),
        Visibility(
          visible: showNotification??false,
          child: FadeInDown(
            duration: const Duration(milliseconds: 400),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                triggerHapticFeedback();
                Get.to(() => const NotificationScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: horizontalScreenPadding, top: 5, bottom: 5, left: 5),
                child: SvgPicture.asset(
                  BaseAssets.icNotification,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight+(bottomWidgetHeight??0));
}