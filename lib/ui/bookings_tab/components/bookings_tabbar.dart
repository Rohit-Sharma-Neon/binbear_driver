import 'package:binbeardriver/ui/bookings_tab/controller/bookings_controller.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingsTabBar extends StatelessWidget {
  BookingsTabBar({super.key});

  final BookingsController controller = Get.find<BookingsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 32, left:32, bottom: 18),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(90)),
      child: TabBar(
        controller: controller.tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        dividerColor: Colors.transparent,
        indicatorWeight: 0,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: BaseColors.primaryColor,
        ),
        tabs: [
          Tab(height: 40, text: "New".tr),
          Tab(height: 40, text: "On-Going".tr),
          Tab(height: 40, text: "Completed".tr)
        ],
      ),
    );
  }
}
