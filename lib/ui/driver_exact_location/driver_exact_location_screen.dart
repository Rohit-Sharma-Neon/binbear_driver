import 'package:binbeardriver/ui/base_components/base_map_header_shadow.dart';
import 'package:binbeardriver/ui/base_components/base_outlined_button.dart';
import 'package:binbeardriver/ui/driver_exact_location/controller/driver_excate_location_controller.dart';
import 'package:binbeardriver/ui/onboardings/splash/controller/base_controller.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_text.dart';

class DriverExactLocationScreen extends StatefulWidget {
  final LatLng latLng;
  // final DriverData? driverData;
  final String? bookingId;
  const DriverExactLocationScreen(
      {super.key, required this.latLng, this.bookingId});
  @override
  State<DriverExactLocationScreen> createState() =>
      _DriverExactLocationScreenState();
}

class _DriverExactLocationScreenState extends State<DriverExactLocationScreen> {
  DriverExactLocationController controller =
      Get.put(DriverExactLocationController());

  @override
  void initState() {
    super.initState();
    controller.getMyBookingsApi(widget.bookingId ?? "");
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
          title: "BinBear Details",
          contentColor: Colors.black,
          titleSize: 19,
          fontWeight: FontWeight.w600,
        ),
        body: Stack(
          children: [
            Obx(
              () => GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: controller.getInitialCameraPosition(
                  latLng: LatLng(
                    double.parse(
                        "${controller.bookingDetailData.value?.pickupAddress?.lat ?? "0"}"),
                    double.parse(
                        "${controller.bookingDetailData.value?.pickupAddress?.lng ?? "0"}"),
                  ),
                ),
                onMapCreated: (GoogleMapController googleMapController) {
                  if (!(controller.mapController.isCompleted)) {
                    controller.mapController.complete(googleMapController);
                   
                    setState(() {});
                  }
                },
                markers: {
                  Marker(
                    markerId: const MarkerId("starting_marker"),
                    position: LatLng(
                      double.parse(
                          "${controller.bookingDetailData.value?.pickupAddress?.lat ?? "0"}"),
                      double.parse(
                          "${controller.bookingDetailData.value?.pickupAddress?.lng ?? "0"}"),
                    ),
                    infoWindow: const InfoWindow(
                      title: "Driver Location",
                    ),
                    icon: Get.find<BaseController>().icStartMarkerPin,
                  )
                },
              ),
            ),
            const BaseMapHeaderShadow()
          ],
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
              left: horizontalScreenPadding,
              right: horizontalScreenPadding,
              top: 20,
              bottom: 10),
          margin: const EdgeInsets.only(
              right: horizontalScreenPadding,
              left: horizontalScreenPadding,
              bottom: 36),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      BaseAssets.icBinBears,
                      height: 32,
                    ),
                    BaseText(
                      leftMargin: 10,
                      value:
                          "${controller.bookingDetailData.value?.binbearData?.name ?? ""}",
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Divider(color: Colors.grey.shade300),
                const BaseText(
                  value: "Assigned Jobs",
                  fontSize: 10.5,
                  color: Color(0xffAAAAAA),
                  fontWeight: FontWeight.w400,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      BaseAssets.icPin,
                      color: BaseColors.primaryColor,
                      width: 24,
                      height: 24,
                    ),
                    Expanded(
                      child: BaseText(
                        leftMargin: 8,
                        value:
                            "${controller.bookingDetailData.value?.pickupAddress?.flatNo ?? ""}, ${controller.bookingDetailData.value?.pickupAddress?.fullAddress ?? ""}",
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      // onTap: (){
                      // triggerHapticFeedback();
                      // Get.to(() => const ChatTab());
                      // },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8, left: 4),
                        child: SvgPicture.asset(BaseAssets.icPinDrop),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SvgPicture.asset(
                      BaseAssets.icCalendar,
                      width: 18,
                      height: 18,
                    ),
                    BaseText(
                      leftMargin: 10,
                      value: formatBackendDate(
                          "${controller.bookingDetailData.value?.createdAt ?? ""}"),
                      fontSize: 13,
                      color: Color(0xff30302E),
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      BaseAssets.icClock,
                      width: 18,
                      height: 18,
                    ),
                    Expanded(
                      child: BaseText(
                        leftMargin: 10,
                        value:
                            "${controller.bookingDetailData.value?.time ?? ""}",
                        fontSize: 13,
                        color: Color(0xff30302E),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    BaseOutlinedButton(
                      topMargin: 0,
                      bottomMargin: 0,
                      leftMargin: 8,
                      btnTopPadding: 6,
                      btnBottomPadding: 6,
                      btnRightPadding: 7,
                      btnLeftPadding: 7,
                      borderRadius: 8,
                      title:
                          "${controller.bookingDetailData.value?.distance ?? ""} miles",
                      titleColor: BaseColors.primaryColor,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
