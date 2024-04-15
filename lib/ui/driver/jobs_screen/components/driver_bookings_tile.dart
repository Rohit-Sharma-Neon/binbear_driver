import 'package:binbeardriver/ui/base_components/base_accept_reject_buttons.dart';
import 'package:binbeardriver/ui/base_components/base_outlined_button.dart';
import 'package:binbeardriver/ui/base_components/base_text.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DriverBookingListTile extends StatelessWidget {
  final double? tileWidth, startingLat, startingLong, endingLat, endingLong;
  final double? topMargin, bottomMargin, rightMargin, leftMargin;
  final String location, date, time, distance;
  final bool isNewBooking, showAcceptRejectButtons, showCurrentLocation, showAssignButton;
  final bool? isAccepted, isCompleted;
  final String bookingId;
  final void Function()? acceptAction;
  final void Function()? rejectAction;
  final void Function()? onTap;
  const DriverBookingListTile(
      {super.key,
      this.tileWidth,
      required this.location,
      required this.date,
      required this.time,
      required this.distance,
      this.topMargin,
      this.bottomMargin,
      this.rightMargin,
      this.leftMargin,
      required this.isNewBooking,
      required this.showAcceptRejectButtons,
      required this.showAssignButton,
        required this.bookingId,
      this.isAccepted,
      this.isCompleted,
      this.startingLat,
      this.startingLong,
      this.endingLat,
      this.endingLong,
      required this.showCurrentLocation,
      this.acceptAction,
      this.rejectAction,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: rightMargin ?? 0,
          bottom: bottomMargin ?? 0,
          left: leftMargin ?? 0,
          top: topMargin ?? 0),
      child: GestureDetector(
        onTap: () {
          triggerHapticFeedback();
          FocusManager.instance.primaryFocus?.unfocus();
          if (onTap != null) {
            onTap!();
          }
        },
        child: Container(
          width: tileWidth ?? MediaQuery.of(context).size.width / 1.24,
          padding: const EdgeInsets.only(left: 10, right: 10, top: 14, bottom: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      value: location,
                      fontSize: 15,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                    value: date,
                    fontSize: 13,
                    color: const Color(0xff30302E),
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    BaseAssets.icClock,
                    width: 18,
                    height: 18,
                  ),
                  Expanded(
                    child: BaseText(
                      leftMargin: 10,
                      value: time,
                      fontSize: 13,
                      color: const Color(0xff30302E),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if(distance!="0"&&distance!="0.0"&&distance!="0.00")
                  BaseOutlinedButton(
                    topMargin: 0,
                    leftMargin: 8,
                    btnTopPadding: 6,
                    btnBottomPadding: 6,
                    btnRightPadding: 7,
                    btnLeftPadding: 7,
                    borderRadius: 8,
                    title: "$distance miles",
                    titleColor: BaseColors.primaryColor,
                  )
                ],
              ),
              Visibility(
                visible: showAcceptRejectButtons,
                child: BaseAcceptRejectButtons(
                  isAccepted: isAccepted ?? false,
                  acceptAction: acceptAction,
                  rejectAction: rejectAction,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
