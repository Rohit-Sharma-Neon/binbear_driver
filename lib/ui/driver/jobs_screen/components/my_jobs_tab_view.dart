import 'package:binbeardriver/ui/base_components/animated_list_builder.dart';
import 'package:binbeardriver/ui/base_components/base_no_data.dart';
import 'package:binbeardriver/ui/base_components/smart_refresher_base_header.dart';
import 'package:binbeardriver/ui/bookings_tab/components/my_bookings_shimmer.dart';
import 'package:binbeardriver/ui/driver/drivers_map_view/drivers_map_view_screen.dart';
import 'package:binbeardriver/ui/driver/jobs_screen/components/driver_bookings_tile.dart';
import 'package:binbeardriver/ui/driver/jobs_screen/controller/jobs_controller.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
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
                          child: DriverBookingListTile(
                            bottomMargin: 18,
                            showAcceptRejectButtons: controller.tabController.index == 0,
                            isNewBooking: controller.tabController.index == 0,
                            location: "${controller.list?[index].pickupAddress?.flatNo?.toString() ?? ""}, ${controller.list?[index].pickupAddress?.fullAddress?.toString() ?? ""}",
                            date: formatBackendDate(controller.list?[index].createdAt?.toString()??""),
                            time: controller.list?[index].time?.toString() ?? "",
                            distance: controller.list?[index].distance?.toString() ?? "",
                            bookingId:controller.list?[index].id.toString() ?? "" ,
                            showCurrentLocation: false,
                            showAssignButton: (controller.list?[index].assignStatus?.toString() ?? "0") == "1",
                            acceptAction: () {
                              controller.bookingActionApi(
                                controller.list?[index].id?.toString() ?? "",
                                "1",
                                index: index,
                              );
                              },
                            rejectAction: () {
                              controller.bookingActionApi(
                                controller.list?[index].id?.toString() ?? "",
                                "2",
                                index: index,
                              );
                            },
                            onTap: (){
                              Get.to( DriverMapViewScreen(
                                jobsData: controller.list?[index],
                                isNewBooking: controller.tabController.index == 0,
                              ));
                              },
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
