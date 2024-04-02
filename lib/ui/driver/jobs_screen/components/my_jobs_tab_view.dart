import 'package:binbeardriver/ui/base_components/animated_list_builder.dart';
import 'package:binbeardriver/ui/base_components/base_no_data.dart';
import 'package:binbeardriver/ui/base_components/bookings_tile.dart';
import 'package:binbeardriver/ui/base_components/smart_refresher_base_header.dart';
import 'package:binbeardriver/ui/bookings_tab/components/my_bookings_shimmer.dart';
import 'package:binbeardriver/ui/driver/jobs_screen/controller/jobs_controller.dart';

import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyJobsTabview extends StatelessWidget {
  const MyJobsTabview({super.key});

  @override
  Widget build(BuildContext context) {
    final JobsController controller = Get.find<JobsController>();
    return AnimationLimiter(
      child: Obx(
        () => SmartRefresher(
          controller: (controller.tabController.index == 0)
              ? controller.upcomingRefreshController
              : controller.pastRefreshController,
          header: const SmartRefresherBaseHeader(),
          onRefresh: () {
            controller.getMyJobsApi();
          },
          child: controller.isLoading.value
              ? const MyBookingsShimmer()
              : (controller.list?.length ?? 0) == 0
                  ? const BaseNoData()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.list?.length ?? 0,
                      padding: const EdgeInsets.only(
                          right: horizontalScreenPadding,
                          left: horizontalScreenPadding,
                          bottom: 80),
                      itemBuilder: (context, index) {
                        return AnimatedListBuilder(
                          index: index,
                          child: BookingListTile(
                            bottomMargin: 18,
                            showAcceptRejectButtons:
                                controller.tabController.index == 0,
                            isPastBooking: controller.tabController.index == 1,
                            location:
                                "${controller.list?[index].pickupAddress?.flatNo ?? ""}, ${controller.list?[index].pickupAddress?.fullAddress ?? ""}",
                            date: formatBackendDate(
                                controller.list?[index].createdAt.toString() ??
                                    ""),
                            time: controller.list?[index].time ?? "",
                            distance:
                                controller.list?[index].distance?.toString() ??
                                    "",
                            showCurrentLocation: false,
                            acceptAction: () {
                              controller.bookingActionApi(
                                  controller.list?[index].id?.toString() ?? "",
                                  "1");
                            },
                            rejectAction: () {
                              controller.bookingActionApi(
                                  controller.list?[index].id?.toString() ?? "",
                                  "2");
                            },
                            // onTap: (){
                            //   Get.to(() => BookingsDetailScreen(isPastBooking: controller.tabController.index == 1, bookingId: controller.list?[index].id?.toString()??""));
                            // },
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
