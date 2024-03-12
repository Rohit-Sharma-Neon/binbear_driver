import 'package:binbeardriver/ui/base_components/base_map_header_shadow.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scaled_app/scaled_app.dart';
import '../../../utils/base_sizes.dart';
import '../../base_components/base_app_bar.dart';
import '../../base_components/base_button.dart';
import '../../base_components/base_container.dart';
import '../../base_components/base_text.dart';
import 'controller/drivers_map_view_controller.dart';

class DriverMapViewScreen extends StatefulWidget {
  const DriverMapViewScreen({super.key});

  @override
  State<DriverMapViewScreen> createState() => _DriverMapViewScreenState();
}

class _DriverMapViewScreenState extends State<DriverMapViewScreen> {

  UpdateWorkStatusController controller = Get.put(UpdateWorkStatusController());

  @override
  void initState() {
    super.initState();
    controller.currentWorkStatus.value = "Pick-Up!";
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
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: controller.kGooglePlex,
              onMapCreated: (GoogleMapController googleMapController) {
                controller.mapController.complete(googleMapController);
              },
            ),
            const BaseMapHeaderShadow()
          ],
        ),
        bottomNavigationBar: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const BaseContainer(
              height: 305,
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
                    value: "3d, Avenue Road",
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  BaseText(
                    topMargin: 2,
                    value: "33.6 miles",
                    fontSize: 11,
                    color: Color(0xffFBE6D3),
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            BaseContainer(
              height: 252,
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
                  const BaseText(
                    topMargin: 2,
                    value: "Can 2 Curb Service",
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
                  Obx(()=>Visibility(
                    replacement: const SizedBox(height: 32),
                    visible: controller.currentWorkStatus.value == "Pick-Up!" || controller.currentWorkStatus.value == "Deliver Back To Home",
                    child: GestureDetector(
                      onTap: (){
                        triggerHapticFeedback();
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(top: 11),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(BaseAssets.icUpload, color: BaseColors.secondaryColor, height: 15),
                              const BaseText(
                                topMargin: 2,
                                leftMargin: 7,
                                value: "Upload a picture",
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                    ),
                  ),
                  ),
                  Obx(()=>BaseButton(
                      title: controller.currentWorkStatus.value,
                      topMargin: 11,
                      bottomMargin: 12,
                      onPressed: controller.onButtonTap,
                      child: controller.getButtonContent(),
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
