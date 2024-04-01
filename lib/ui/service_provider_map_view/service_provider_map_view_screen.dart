import 'package:binbeardriver/ui/assign_job_manually/assign_job_manually_screen.dart';
import 'package:binbeardriver/ui/base_components/base_map_header_shadow.dart';
import 'package:binbeardriver/ui/bookings_tab/controller/bookings_controller.dart';
import 'package:binbeardriver/ui/service_provider_map_view/controller/service_provider_map_view_controller.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scaled_app/scaled_app.dart';
import '../../../utils/base_sizes.dart';
import '../base_components/base_app_bar.dart';
import '../base_components/base_button.dart';
import '../base_components/base_container.dart';
import '../base_components/base_text.dart';

class ServiceProviderMapViewScreen extends StatefulWidget {
  final double? startingLat, startingLong, endingLat, endingLong;
  final bool showCurrentPosition;
  const ServiceProviderMapViewScreen(
      {super.key,
      this.startingLat,
      this.startingLong,
      this.endingLat,
      this.endingLong,
      required this.showCurrentPosition});

  @override
  State<ServiceProviderMapViewScreen> createState() =>
      _ServiceProviderMapViewScreenState();
}

class _ServiceProviderMapViewScreenState
    extends State<ServiceProviderMapViewScreen> {
  BookingsController controller = Get.find<BookingsController>();

  @override
  void initState() {
    super.initState();
    controller.addMarkers(
      southwest: LatLng(widget.startingLat ?? 0, widget.startingLong ?? 0),
      northeast: LatLng(widget.endingLat ?? 0, widget.endingLong ?? 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).scale(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        extendBody: true,
        appBar: const BaseAppBar(
          contentColor: Colors.black,
          titleSize: 19,
          fontWeight: FontWeight.w600,
        ),
        body: Stack(
          children: [
            GetBuilder<BookingsController>(
              builder: (BookingsController controller) {
                print("Widget Rebuild");
                return GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: widget.showCurrentPosition,
                  polylines: Set<Polyline>.of(controller.polylines.values),
                  initialCameraPosition: controller.kGooglePlex,
                  onMapCreated: controller.onMapCreated,
                  markers: controller.markers,
                );
              },
            ),
            const BaseMapHeaderShadow()
          ],
        ),
        bottomNavigationBar: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            BaseContainer(
              height: controller.tabController.index != 0 ? 252 : 305,
              color: BaseColors.secondaryColor,
              borderRadius: 15,
              topPadding: 6,
              bottomPadding: 6,
              rightPadding: horizontalScreenPadding,
              leftPadding: horizontalScreenPadding,
              topMargin: 16,
              bottomMargin: 28,
              rightMargin: horizontalScreenPadding,
              leftMargin: horizontalScreenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BaseText(
                    topMargin: 4,
                    value: "3d, Avenue Road",
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  Row(
                    children: [
                      const BaseText(
                        topMargin: 2,
                        value: "33.6 miles",
                        fontSize: 11,
                        color: Color(0xffFBE6D3),
                        fontWeight: FontWeight.w400,
                      ),
                      Container(
                        width: 4,
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 9),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: BaseColors.primaryColor),
                      ),
                      BaseText(
                        topMargin: 2,
                        value: controller.tabController.index != 0
                            ? "Picked Up"
                            : "Waiting for Driver Response",
                        fontSize: 11,
                        color: const Color(0xffFBE6D3),
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            BaseContainer(
              height: controller.tabController.index != 0 ? 200 : 252,
              color: const Color(0xff330601),
              borderRadius: 15,
              topPadding: 6,
              bottomPadding: 6,
              rightPadding: horizontalScreenPadding,
              leftPadding: horizontalScreenPadding,
              topMargin: 16,
              bottomMargin: 28,
              rightMargin: horizontalScreenPadding,
              leftMargin: horizontalScreenPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BaseText(
                    topMargin: 11,
                    value: "Service Info",
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: BaseText(
                          topMargin: 10,
                          value: "Service Requested",
                          fontSize: 11.5,
                          color: const Color(0xffFBE6D3).withOpacity(0.42),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        child: BaseText(
                          topMargin: 10,
                          value: "User Name",
                          textAlign: TextAlign.right,
                          fontSize: 11.5,
                          color: const Color(0xffFBE6D3).withOpacity(0.42),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: BaseText(
                          topMargin: 2,
                          value: "Can 2 Curb Service",
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        child: BaseText(
                          topMargin: 2,
                          textAlign: TextAlign.end,
                          value: "Peter Parker",
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  BaseText(
                    topMargin: 10,
                    value: "Pickup",
                    fontSize: 11.5,
                    color: const Color(0xffFBE6D3).withOpacity(0.42),
                    fontWeight: FontWeight.w400,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(BaseAssets.icPin,
                          color: BaseColors.secondaryColor, height: 12),
                      const BaseText(
                        topMargin: 2,
                        leftMargin: 3.5,
                        value: "3d, Avenue road, usa",
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Visibility(
                    visible: controller.tabController.index != 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BaseText(
                          topMargin: 10,
                          value: "Driver Name",
                          fontSize: 11.5,
                          color: const Color(0xffFBE6D3).withOpacity(0.42),
                          fontWeight: FontWeight.w400,
                        ),
                        const BaseText(
                          topMargin: 2,
                          value: "John Sinha",
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Visibility(
                    visible: controller.tabController.index == 0,
                    child: BaseButton(
                      title: "Assign Job Manually",
                      topMargin: 11,
                      bottomMargin: 12,
                      onPressed: () {
                        Get.to(() => const AssignJobManuallyScreen());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
