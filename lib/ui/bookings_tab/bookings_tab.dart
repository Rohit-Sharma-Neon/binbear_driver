import 'package:animate_do/animate_do.dart';
import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/bookings_tab/components/bookings_tabbar.dart';
import 'package:binbeardriver/ui/bookings_tab/components/my_bookings_tab_view.dart';
import 'package:binbeardriver/ui/bookings_tab/controller/bookings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingsTab extends StatefulWidget {
  const BookingsTab({super.key});

  @override
  State<BookingsTab> createState() => _BookingsTabState();
}

class _BookingsTabState extends State<BookingsTab> {
  BookingsController controller = Get.put(BookingsController());
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: BaseAppBar(
            title: "My Bookings",
            showNotification: true,
            showDrawerIcon: true,
            bottomWidgetHeight: 70,
            bottomChild: FadeInDown(
              duration: const Duration(milliseconds: 400),
              child: BookingsTabBar(),
            ),
          ),
          body: TabBarView(
            controller: controller.tabController,
            children: const [
              MyBookingsTabView(),
              MyBookingsTabView(),
              MyBookingsTabView(),
            ],
          )),
    );
  }
}
