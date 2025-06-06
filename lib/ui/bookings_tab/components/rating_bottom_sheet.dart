import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:binbeardriver/ui/base_components/animated_column.dart';
import 'package:binbeardriver/ui/base_components/base_button.dart';
import 'package:binbeardriver/ui/base_components/base_text.dart';

class RatingBottomSheet extends StatelessWidget {
  const RatingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedColumn(
      leftPadding: 20,
      rightPadding: 20,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            children: [
               const Expanded(
                child: BaseText(
                  value: "Rate your BinBear!",
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: (){
                  triggerHapticFeedback();
                  Get.back(closeOverlays: true);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SvgPicture.asset(BaseAssets.icCross),
                ),
              ),
            ],
          ),
        ),
        RatingBar(
          initialRating: 3,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          minRating: 1,
          ratingWidget: RatingWidget(
            full: SvgPicture.asset(BaseAssets.icFillRating),
            empty: SvgPicture.asset(BaseAssets.icUnFillRating),
            half: SvgPicture.asset(BaseAssets.icUnFillRating),
          ),
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          onRatingUpdate: (rating) {
          },
        ),
        BaseButton(
          title: "Submit",
          bottomMargin: 20,
          onPressed: (){
            Get.back(closeOverlays: true, canPop: false);
          },
        )
      ],
    );
  }
}
