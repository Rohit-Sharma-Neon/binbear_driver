import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:binbeardriver/ui/base_components/base_text.dart';

class DriversListingTile extends StatelessWidget {
  final bool isChecked;
  final bool? showEditDeleteButtons;
  final String title;
  final void Function()? onTap;
  final void Function()? onEdit;
  final void Function()? onDelete;
  const DriversListingTile({super.key, required this.title, required this.onTap, required this.isChecked, this.showEditDeleteButtons, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 18, right: horizontalScreenPadding, left: horizontalScreenPadding),
        padding: const EdgeInsets.only(left: 14, bottom: 10, top: 10, right: 0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
          border: Border.all(
            width: isChecked ? 1.5 : 0,
            color: isChecked ? BaseColors.secondaryColor : Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              spreadRadius: isChecked ? 4: 0,
              blurRadius: isChecked ? 4 : 0,
              offset: const Offset(0,4),
              color: isChecked ? BaseColors.primaryColor.withOpacity(0.8) : Colors.transparent,
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              BaseAssets.icBinBears,
              height: 38,
              width: 38,
            ),
            Expanded(
              child: BaseText(
                topMargin: 13,
                leftMargin: 8,
                bottomMargin: 18,
                value: title,
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            Visibility(
              visible: isChecked,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SvgPicture.asset(BaseAssets.icCheck),
              ),
            ),
            Visibility(
              visible: showEditDeleteButtons??false,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: (){
                      triggerHapticFeedback();
                      onEdit!();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, left: 6),
                      child: SvgPicture.asset(BaseAssets.icEdit),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      triggerHapticFeedback();
                      onDelete!();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 17, left: 10),
                      child: SvgPicture.asset(BaseAssets.icDelete),
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

