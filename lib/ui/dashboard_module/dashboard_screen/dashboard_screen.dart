import 'package:binbeardriver/ui/bookings_tab/bookings_tab.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../base_components/base_drawer.dart';
import '../../base_components/base_scaffold_background.dart';

import '../../chat_tab/chat_tab.dart';
import '../../home_tab/home_tab.dart';
import '../../profile_tab/profile_tab.dart';
import 'components/bottom_nav_items.dart';
import 'controller/dashboard_controller.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});
  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: BaseScaffoldBackground(
        child: Scaffold(
          key: controller.scaffoldKey,
          drawer: const BaseDrawer(),
          drawerEdgeDragWidth: 0.0,
          drawerEnableOpenDragGesture: false,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            children: const [
              HomeTab(),
              BookingsTab(),
              ChatTab(),
              ProfileTab(),
            ],
            onPageChanged: (index) {
              controller.selectedNavIndex.value = index;
            },
          ),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              currentIndex: controller.selectedNavIndex.value,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              selectedItemColor: BaseColors.primaryColor,
              unselectedItemColor: const Color(0xff330601),
              unselectedFontSize: 12,
              selectedLabelStyle: const TextStyle(
                  fontSize: 12, color: BaseColors.primaryColor, height: 2.5),
              unselectedLabelStyle: const TextStyle(
                  fontSize: 12, color: BaseColors.primaryColor, height: 2.5),
              onTap: controller.changeTab,
              items: [
                bottomNavigationBarItem(
                  icon: BaseAssets.navHomeSelected,
                  title: "Home",
                ),
                bottomNavigationBarItem(
                  icon: BaseAssets.navBookingsUnselected,
                  title: "Bookings",
                ),
                bottomNavigationBarItem(
                  icon: BaseAssets.navChatUnselected,
                  title: "Chat",
                ),
                bottomNavigationBarItem(
                  icon: BaseAssets.navUserUnselected,
                  title: "Account",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
