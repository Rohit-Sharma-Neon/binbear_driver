  import 'package:binbeardriver/ui/base_components/animated_list_builder.dart';
  import 'package:binbeardriver/ui/base_components/base_no_data.dart';
  import 'package:binbeardriver/ui/base_components/bookings_tile.dart';
  import 'package:binbeardriver/ui/base_components/smart_refresher_base_header.dart';
  import 'package:binbeardriver/ui/bookings_tab/components/my_bookings_shimmer.dart';
  import 'package:binbeardriver/ui/bookings_tab/controller/bookings_controller.dart';
import 'package:binbeardriver/ui/driver/drivers_map_view/drivers_map_view_screen.dart';
import 'package:binbeardriver/ui/service_provider_map_view/service_provider_map_view_screen.dart';
  import 'package:binbeardriver/utils/base_functions.dart';
  import 'package:binbeardriver/utils/base_variables.dart';
import 'package:binbeardriver/utils/storage_keys.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
  import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
  import 'package:pull_to_refresh/pull_to_refresh.dart';

  class MyBookingsTabView extends StatelessWidget {
    const MyBookingsTabView({super.key});

    @override
    Widget build(BuildContext context) {
      final BookingsController controller = Get.find<BookingsController>();
      return AnimationLimiter(
        child: Obx(
          () => SmartRefresher(
            controller: (controller.tabController.index == 0)
                ? controller.upcomingRefreshController
                : controller.pastRefreshController,
            header: const SmartRefresherBaseHeader(),
            onRefresh: () {
              controller.getMyBookingsApi();
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
                              isAccepted: controller.list?[index].status.toString() == "2" ,
                              showAcceptRejectButtons: controller.tabController.index == 0,
                              isPastBooking: controller.tabController.index == 1,
                              location: "${controller.list?[index].pickupAddress?.flatNo ?? ""}, ${controller.list?[index].pickupAddress?.fullAddress ?? ""}",
                              date: formatBackendDate(controller.list?[index].createdAt.toString() ?? ""),
                              time: controller.list?[index].time ?? "",
                              distance: controller.list?[index].distance?.toString() ?? "",
                              showCurrentLocation: false,
                              acceptAction: (){
                                controller.bookingActionApi(controller.list?[index].id?.toString()??"","1",index);
                              },
                              rejectAction: () {
                                controller.bookingActionApi(
                                    controller.list?[index].id?.toString() ?? "",
                                    "2",
                                    index,
                                );
                              },
                              onTap: (){
                                // Get.to(() => BookingsDetailScreen(isPastBooking: controller.tabController.index == 1, bookingId: controller.list?[index].id?.toString()??""));
                                if (GetStorage().read(StorageKeys.isUserDriver)??false) {
                                  Get.to(const DriverMapViewScreen());
                                } else {
                                  Get.to(ServiceProviderMapViewScreen(
                                    startingLat: double.parse((controller.list?[index].pickupAddress?.lat??0.0).toString()),
                                    startingLong: double.parse((controller.list?[index].pickupAddress?.lng??0.0).toString()),
                                    endingLat:  double.parse((controller.list?[index].assignedProviderAddress?.lat??0.0).toString()),
                                    endingLong:  double.parse((controller.list?[index].assignedProviderAddress?.lng??0.0).toString()),
                                    showCurrentPosition: false,
                                  ));
                                }
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
