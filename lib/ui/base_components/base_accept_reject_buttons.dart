import 'package:binbeardriver/utils/base_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'base_button.dart';

class BaseAcceptRejectButtons extends StatelessWidget {
  final double? topMargin, bottomMargin;
  final bool? isAccepted;
  final void Function()? acceptAction;
    final void Function()? rejectAction;
  const BaseAcceptRejectButtons(
      {super.key, this.topMargin, this.bottomMargin, this.isAccepted, this.acceptAction,this.rejectAction});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BaseButton(
            btnHeight: 37,
            onPressed: acceptAction ?? () {},
            topMargin: topMargin ?? 0,
            bottomMargin: bottomMargin ?? 0,
            title: !(isAccepted ?? false) ? "Accept" : "Accepted",
            fontSize: 15,
            fontWeight:
                !(isAccepted ?? false) ? FontWeight.w300 : FontWeight.w500,
            titleColor: !(isAccepted ?? false) ? Colors.white : Colors.black,
            btnColor: !(isAccepted ?? false)
                ? BaseColors.secondaryColor
                : BaseColors.tertiaryColor,
          ),
        ),
        Visibility(
          visible: !(isAccepted ?? false),
          child: const SizedBox(width: 14),
        ),
        Visibility(
          visible: !(isAccepted ?? false),
          child: Expanded(
            child: BaseButton(
              onPressed: rejectAction ??(){},
              btnHeight: 37,
              fontSize: 15,
              topMargin: topMargin ?? 0,
              bottomMargin: bottomMargin ?? 0,
              title: "Reject",
            ),
          ),
        ),
      ],
    );
  }
}
