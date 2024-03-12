import 'package:binbeardriver/ui/assign_job_manually/assign_job_manually_screen.dart';
import 'package:binbeardriver/ui/base_components/base_map_header_shadow.dart';
import 'package:binbeardriver/ui/base_components/base_outlined_button.dart';
import 'package:binbeardriver/ui/bookings_tab/controller/bookings_controller.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scaled_app/scaled_app.dart';
import '../../../utils/base_sizes.dart';
import '../base_components/base_app_bar.dart';
import '../base_components/base_button.dart';
import '../base_components/base_container.dart';
import '../base_components/base_text.dart';

class DriverExactLocationScreen extends StatefulWidget {
  const DriverExactLocationScreen({super.key});
  @override
  State<DriverExactLocationScreen> createState() => _DriverExactLocationScreenState();
}

class _DriverExactLocationScreenState extends State<DriverExactLocationScreen> {
  BookingsController controller = Get.find<BookingsController>();

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
        bottomNavigationBar: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: horizontalScreenPadding, right: horizontalScreenPadding, top: 20, bottom: 10),
          margin: const EdgeInsets.only(right: horizontalScreenPadding, left: horizontalScreenPadding, bottom: 36),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    BaseAssets.icBinBears,
                    height: 32,
                  ),
                  const BaseText(
                    leftMargin: 10,
                    value: "Peter Parker",
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
                  const Expanded(
                    child: BaseText(
                      leftMargin: 8,
                      value: "123, bellaforte, USA",
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
                  const BaseText(
                    leftMargin: 10,
                    value: "01-16-2024",
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
                  const Expanded(
                    child: BaseText(
                      leftMargin: 10,
                      value: "Before 1 pm",
                      fontSize: 13,
                      color: Color(0xff30302E),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const BaseOutlinedButton(
                    topMargin: 0,
                    bottomMargin: 0,
                    leftMargin: 8,
                    btnTopPadding: 6,
                    btnBottomPadding: 6,
                    btnRightPadding: 7,
                    btnLeftPadding: 7,
                    borderRadius: 8,
                    title: "3 miles",
                    titleColor: BaseColors.primaryColor,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
