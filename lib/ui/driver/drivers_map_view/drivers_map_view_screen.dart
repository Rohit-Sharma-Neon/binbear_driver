import 'package:binbeardriver/ui/base_components/base_map_header_shadow.dart';
import 'package:binbeardriver/ui/driver/jobs_screen/model/my_jobs_response.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_button.dart';
import 'package:binbeardriver/ui/base_components/base_container.dart';
import 'package:binbeardriver/ui/base_components/base_text.dart';
import 'package:binbeardriver/ui/driver/drivers_map_view/controller/drivers_map_view_controller.dart';

class DriverMapViewScreen extends StatefulWidget {
  final Jobs? jobsData;
  final bool isNewBooking;
  const DriverMapViewScreen({super.key, required this.jobsData, required this.isNewBooking});

  @override
  State<DriverMapViewScreen> createState() => _DriverMapViewScreenState();
}

class _DriverMapViewScreenState extends State<DriverMapViewScreen> {

  DriversMapViewController controller = Get.put(DriversMapViewController());

  @override
  void initState() {
    super.initState();
    controller.currentWorkStatus.value = "Pick-Up!";
    if ((widget.jobsData?.pickupAddress?.lat?.toString()??"").isNotEmpty && (widget.jobsData?.pickupAddress?.lng?.toString()??"").isNotEmpty) {
      controller.addMarker(
          latitude: double.parse((widget.jobsData?.pickupAddress?.lat??defaultLat).toString()),
          longitude: double.parse((widget.jobsData?.pickupAddress?.lng??defaultLng).toString()),
      );
    }
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
            GetBuilder<DriversMapViewController>(
              builder: (DriversMapViewController controller) {
                print("Widget Rebuild");
                return GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  initialCameraPosition: controller.getInitialCameraPosition(
                    lat: double.parse((widget.jobsData?.pickupAddress?.lat??defaultLat).toString()),
                    long: double.parse((widget.jobsData?.pickupAddress?.lng??defaultLng).toString()),
                  ),
                  markers: Set<Marker>.of(controller.markers),
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController googleMapController) {
                    if(!controller.mapController.isCompleted){
                      controller.mapController.complete(googleMapController);
                    }
                  },
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
              height: widget.isNewBooking ? 215 : 305,
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
                  BaseText(
                    topMargin: 4,
                    value: (widget.jobsData?.pickupAddress?.fullAddress?.toString()??"").split(",").first,
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  BaseText(
                    topMargin: 2,
                    value: "${widget.jobsData?.distance?.toString() ?? "0"} miles",
                    fontSize: 11,
                    color: const Color(0xffFBE6D3),
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            BaseContainer(
              height: widget.isNewBooking ? 160 : 252,
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
                  BaseText(
                    topMargin: 10,
                    value: "Service Requested",
                    fontSize: 11.5,
                    color: const Color(0xffFBE6D3).withOpacity(0.42),
                    fontWeight: FontWeight.w400,
                  ),
                  BaseText(
                    topMargin: 2,
                    value: getServiceTitleById(serviceId: widget.jobsData?.categoryId?.toString()??""),
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
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
                      SvgPicture.asset(BaseAssets.icPin, color: BaseColors.secondaryColor, height: 12),
                      Expanded(
                        child: BaseText(
                          topMargin: 2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          leftMargin: 3.5,
                          value: (widget.jobsData?.pickupAddress?.flatNo?.toString()??"")+(widget.jobsData?.pickupAddress?.fullAddress?.toString()??""),
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: widget.isNewBooking == false,
                    child: Obx(()=>Visibility(
                      replacement: const SizedBox(height: 32),
                      visible: controller.currentWorkStatus.value == "Pick-Up!" || controller.currentWorkStatus.value == "Deliver Back To Home",
                      child: GestureDetector(
                        onTap: (){
                          triggerHapticFeedback();
                          showMediaPicker(isCropEnabled: true).then((value) {
                            if ((value?.path??"").isNotEmpty) {
                              controller.selectedImageFile?.value = value;
                            }
                          });
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(top: 11),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(BaseAssets.icUpload, color: BaseColors.secondaryColor, height: 15),
                                Expanded(
                                  child: BaseText(
                                    topMargin: 2,
                                    leftMargin: 7,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    value: (controller.selectedImageFile?.value?.path??"").isEmpty ? "Upload a picture" : (controller.selectedImageFile?.value?.path??"").split("/").last,
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                    ),
                    ),
                  ),
                  Visibility(
                    visible: widget.isNewBooking == false,
                    child: Obx(()=>BaseButton(
                        title: controller.currentWorkStatus.value,
                        topMargin: 11,
                        bottomMargin: 12,
                        onPressed: (){
                          controller.onButtonTap(bookingId: widget.jobsData?.id?.toString()??"");
                        },
                        child: controller.getButtonContent(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
