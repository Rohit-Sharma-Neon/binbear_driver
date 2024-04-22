import 'package:binbeardriver/ui/driver/jobs_screen/components/my_jobs_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_drawer.dart';
import 'package:binbeardriver/ui/base_components/base_scaffold_background.dart';
import 'package:binbeardriver/ui/driver/jobs_screen/components/bookings_tabbar.dart';
import 'package:binbeardriver/ui/driver/jobs_screen/controller/jobs_controller.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {

  JobsController controller = Get.put(JobsController());
  // BookingsController bookingsController = Get.put(BookingsController());
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // FlutterBackgroundService().invoke('setAsBackground');
  }

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
                children: const [
                MyJobsTabview(),
                MyJobsTabview()
                ],
              )
          ),
        ),
      ),
    );
  }
}