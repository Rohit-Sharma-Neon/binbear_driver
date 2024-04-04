import 'package:binbeardriver/ui/driver_exact_location/driver_exact_location_screen.dart';
import 'package:binbeardriver/ui/drivers_listing/drivers_listing.dart';
import 'package:binbeardriver/ui/home_tab/components/home_booking_shimmer.dart';
import 'package:binbeardriver/ui/home_tab/components/home_drivers_shimmer.dart';
import 'package:binbeardriver/ui/home_tab/controller/home_tab_controller.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:binbeardriver/ui/base_components/animated_column.dart';
import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_scaffold_background.dart';
import 'package:binbeardriver/ui/base_components/base_text.dart';
import 'package:binbeardriver/ui/base_components/base_text_button.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:binbeardriver/ui/base_components/bookings_tile.dart';
import 'package:binbeardriver/ui/dashboard_module/dashboard_screen/controller/dashboard_controller.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  DashboardController dashboardController = Get.find<DashboardController>();
  HomeTabController homeTabController = Get.put(HomeTabController());

  List<String> serviceImages = [
    "assets/delete/can_2_curb_service.svg",
    "assets/delete/bulk_trash_pickup.svg",
    "assets/delete/trash_can_cleaning.svg",
  ];

  // List<String> serviceTitles = [
  //   "Peter Parker",
  //   "John Doe",
  //   "Peter Parker",
  // ];

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        appBar: const BaseAppBar(
          showNotification: true,
          showDrawerIcon: true,
          showSwitchButton: true,
        ),
        body: SmartRefresher(
          controller: homeTabController.refreshController,
          header:
              const WaterDropHeader(waterDropColor: BaseColors.primaryColor),
          onRefresh: () {
            homeTabController.getHomeData();
          },
          child: SingleChildScrollView(
            child: AnimatedColumn(
              rightPadding: 0,
              leftPadding: 0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Quick Links
                const BaseText(
                  topMargin: 5,
                  bottomMargin: 6,
                  leftMargin: horizontalScreenPadding,
                  value: "Quick Links",
                  fontSize: 19,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 120,
                        margin: const EdgeInsets.only(
                            left: horizontalScreenPadding, right: 12),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xffDE875A),
                              Color(0xffB23C14),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: SvgPicture.asset(
                                        BaseAssets.icTotalEarning),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.5),
                                    child: SvgPicture.asset(
                                        BaseAssets.icQuickLinksDecoration),
                                  ),
                                ],
                              ),
                              const BaseText(
                                topMargin: 9,
                                value: "Total Earning",
                                fontSize: 12,
                                color: Color(0xffFBE6D3),
                                leftMargin: horizontalScreenPadding + 4,
                                fontWeight: FontWeight.w400,
                              ),
                              BaseText(
                                topMargin: 2,
                                value: "\$ ${homeTabController.totalEarning}",
                                fontSize: 19,
                                color: Colors.white,
                                leftMargin: horizontalScreenPadding + 4,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 120,
                        margin: const EdgeInsets.only(
                            left: horizontalScreenPadding, right: 12),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xffB23C14),
                              Color(0xffDE875A),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: SvgPicture.asset(
                                        BaseAssets.icTotalBookings),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.5),
                                    child: SvgPicture.asset(
                                        BaseAssets.icQuickLinksDecoration),
                                  ),
                                ],
                              ),
                              const BaseText(
                                topMargin: 9,
                                value: "Total Bookings",
                                fontSize: 12,
                                color: Color(0xffFBE6D3),
                                leftMargin: horizontalScreenPadding + 4,
                                fontWeight: FontWeight.w400,
                              ),
                              BaseText(
                                topMargin: 2,
                                value: "${homeTabController.totalBooking}",
                                fontSize: 19,
                                color: Colors.white,
                                leftMargin: horizontalScreenPadding + 4,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// New Bookings
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 6,
                        child: BaseText(
                          value: "New Bookings",
                          fontSize: 19,
                          leftMargin: horizontalScreenPadding,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: BaseTextButton(
                          title: "See All",
                          fontSize: 14,
                          rightMargin: 0,
                          fontWeight: FontWeight.w700,
                          onPressed: () {
                            dashboardController.changeTab(1);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Obx(
                  () => homeTabController.isHomeLoading.value
                      ? const HomeBookingShimmer()
                      : (homeTabController.allbookings?.length ?? 0) == 0
                          ? Center(
                              child: BaseText(
                                topMargin: 4,
                                value: "No Bookings Found!",
                                fontSize: 16,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: SizedBox(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: homeTabController.allbookings?.length ?? 0,
                                  padding: const EdgeInsets.only(left: horizontalScreenPadding),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return BookingListTile(
                                      showCurrentLocation: false,
                                      isPastBooking: false,
                                      rightMargin: 6,
                                      location: "${homeTabController.allbookings?[index]?.pickupAddress?.flatNo ?? ""}, ${homeTabController.allbookings?[index]?.pickupAddress?.fullAddress ?? ""}",
                                      date: formatBackendDate(homeTabController.allbookings?[index]?.createdAt.toString() ?? ""),
                                      time: homeTabController.allbookings?[index]?.time ?? "",
                                      bookingId:homeTabController.allbookings?[index]?.id.toString() ?? "",
                                      distance: "${homeTabController.allbookings?[index]?.distance ?? ""}",
                                      showAcceptRejectButtons: true,
                                      showAssignButton: (homeTabController.allbookings?[index]?.assignStatus?.toString() ?? "0") == "1",
                                       acceptAction: () {
                                        homeTabController.bookingActionApi(
                                          homeTabController.allbookings?[index]?.id?.toString() ?? "",
                                          "1",
                                          index,
                                        );
                                      },
                                      rejectAction: () {
                                        homeTabController.bookingActionApi(
                                          homeTabController.allbookings?[index]?.id?.toString() ?? "",
                                          "2",
                                          index,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                ),

                /// Drivers
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 6,
                        child: BaseText(
                          value: "Drivers",
                          fontSize: 19,
                          leftMargin: horizontalScreenPadding,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: BaseTextButton(
                          title: "See All",
                          fontSize: 14,
                          rightMargin: 0,
                          fontWeight: FontWeight.w700,
                          onPressed: () {
                            Get.to(() => const DriversListing());
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Obx(
                  () => homeTabController.isHomeLoading.value
                      ? const HomeDriversShimmer()
                      : (homeTabController.allDrivers?.length ?? 0) == 0
                          ? Center(
                              child: BaseText(
                                topMargin: 4,
                                value: "No Drivers Found!",
                                fontSize: 16,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : SizedBox(
                              height: 100,
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(
                                    left: horizontalScreenPadding),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    (homeTabController.allDrivers?.length??0) > 4 ? 4 : homeTabController.allDrivers?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      triggerHapticFeedback();
                                      Get.to(() => DriverExactLocationScreen(
                                          latLng: homeTabController
                                              .testingLatLngList[index]));
                                    },
                                    child: Stack(
                                      clipBehavior: Clip.hardEdge,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                          width: 150,
                                          margin:
                                              const EdgeInsets.only(right: 12),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                  BaseAssets.icBinBears,
                                                  height: 45),
                                              BaseText(
                                                topMargin: 14,
                                                textAlign: TextAlign.center,
                                                value: homeTabController
                                                        .allDrivers?[index]
                                                        ?.name ??
                                                    "",
                                                fontSize: 13,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
