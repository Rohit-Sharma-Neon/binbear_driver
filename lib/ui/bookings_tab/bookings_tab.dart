import '../base_components/animated_list_builder.dart';
import '../base_components/base_app_bar.dart';
import '../base_components/base_scaffold_background.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../base_components/bookings_tile.dart';
import 'components/bookings_tabbar.dart';
import 'controller/bookings_controller.dart';

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
      child: BaseScaffoldBackground(
        child: Scaffold(
            appBar: BaseAppBar(
              title: "My Bookings",
              showNotification: true,
              showDrawerIcon: true,
              showSwitchButton: true,
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
                      child: BookingListTile(
                        bottomMargin: 18,
                        isPastBooking: false,
                        startingLat: 26.830627552927318,
                        startingLong: 75.76585545592367,
                        endingLat: 26.854497684441302,
                        endingLong: 75.76668925715434,
                        location: "123, bellaforte, USA",
                        date: "01-16-2024",
                        time: "Between 6 PM prior evening to 6 AM Service Day",
                        distance: "3",
                        showAcceptRejectButtons: true,
                        isAccepted: index == 1,
                        isCompleted: false,
                        showCurrentLocation: false,
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
                        bottomMargin: 18,
                        showCurrentLocation: true,
                        isPastBooking: false,
                        startingLat: 26.8404944,
                        startingLong: 75.7800145,
                        endingLat: 26.8425322,
                        endingLong: 75.7656885,
                        location: "123, bellaforte, USA",
                        date: "01-16-2024",
                        time: "Between 6 PM prior evening to 6 AM Service Day",
                        distance: "3",
                        showAcceptRejectButtons: false,
                        isCompleted: false,
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
                        showCurrentLocation: false,
                        bottomMargin: 18,
                        isPastBooking: true,
                        location: "123, bellaforte, USA",
                        date: "01-16-2024",
                        time: "Between 6 PM prior evening to 6 AM Service Day",
                        distance: "3",
                        showAcceptRejectButtons: false,
                        isCompleted: true,
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
