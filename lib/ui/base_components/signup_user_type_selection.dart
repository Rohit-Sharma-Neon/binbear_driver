import 'base_text.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpUserTypeSelection extends StatelessWidget {
  final bool? showMostPopularTag;
  final bool isChecked;
  final String imageUrl, title;
  final String? price;
  final void Function() onTap;
  const SignUpUserTypeSelection({super.key, this.showMostPopularTag, required this.imageUrl, required this.title, required this.onTap, required this.isChecked, this.price});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: isChecked ? Colors.white : BaseColors.tertiaryColor,
          border: Border.all(
            width: isChecked ? 1 : 0,
            color: isChecked ? BaseColors.secondaryColor : Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              spreadRadius: isChecked ? 2: 0,
              blurRadius: isChecked ? 4 : 0,
              offset: const Offset(0,3),
              color: isChecked ? BaseColors.primaryColor.withOpacity(0.3) : Colors.transparent,
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            BaseText(
              height: 0,
              topMargin: 10,
              value: title,
              textAlign: TextAlign.center,
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            Visibility(
              visible: isChecked,
              child: Positioned(
                  right: 7,
                  top: 7,
                  child: SvgPicture.asset(BaseAssets.icCheck)
              ),
            ),
            Positioned(
              bottom: 50,
              child: SvgPicture.asset(
                imageUrl,
                height: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

