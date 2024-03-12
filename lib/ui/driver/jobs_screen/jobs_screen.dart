import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../base_components/animated_list_builder.dart';
import '../../base_components/base_app_bar.dart';
import '../../base_components/base_drawer.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/bookings_tile.dart';
import 'components/bookings_tabbar.dart';
import 'controller/jobs_controller.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {

  JobsController controller = Get.put(JobsController());
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: DefaultTabController(
        length: 2,
        child: BaseScaffoldBackground(
          child: Scaffold(
              key: controller.jobsScaffoldKey,
              drawer: const BaseDrawer(),
              drawerEdgeDragWidth: 0.0,
              drawerEnableOpenDragGesture: false,
              appBar: BaseAppBar(
                title: "Jobs",
                showNotification: true,
                showDrawerIcon: true,
                bottomWidgetHeight: 70,
                bottomChild: BookingsTabBar(),
            ),
            body: TabBarView(
              controller: controller.tabController,
              children: [
                AnimationLimiter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    padding: const EdgeInsets.only(right: horizontalScreenPadding, left: horizontalScreenPadding, bottom: 80),
                    itemBuilder: (context, index){
                      return AnimatedListBuilder(
                        index: index,
                        child: const BookingListTile(
                          showCurrentLocation: true,
                          bottomMargin: 18,
                          isPastBooking: false,
                          location: "123, bellaforte, USA",
                          date: "01-16-2024",
                          time: "Between 6 PM prior evening to 6 AM Service Day",
                          distance: "3",
                          showAcceptRejectButtons: true,
                        ),
                      );
                    },
                  ),
                ),
                AnimationLimiter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    padding: const EdgeInsets.only(right: horizontalScreenPadding, left: horizontalScreenPadding, bottom: 80),
                    itemBuilder: (context, index){
                      return AnimatedListBuilder(
                        index: index,
                        child: const BookingListTile(
                          showCurrentLocation: true,
                          bottomMargin: 18,
                          isPastBooking: true,
                          location: "123, bellaforte, USA",
                          date: "01-16-2024",
                          time: "Between 6 PM prior evening to 6 AM Service Day",
                          distance: "3",
                          showAcceptRejectButtons: false,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}