import 'package:binbeardriver/utils/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:binbeardriver/ui/driver/jobs_screen/controller/jobs_controller.dart';

class BookingsTabBar extends StatelessWidget {
  BookingsTabBar({super.key});

  final JobsController controller = Get.find<JobsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 40, left: 40, bottom: 18),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(90)
      ),
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
          Tab(height: 40, text: "My Jobs".tr)
        ],
      ),
    );
  }
}
