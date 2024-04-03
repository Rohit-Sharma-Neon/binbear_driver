import 'package:binbeardriver/ui/base_components/base_shimmer.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:binbeardriver/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeDriversShimmer extends StatelessWidget {
  const HomeDriversShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            width: 150,
            height: 110,
            margin: const EdgeInsets.only(
              left: horizontalScreenPadding,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseShimmer(width: 60, height: 50, borderRadius: 5),
                BaseShimmer(
                  width: 100,
                  height: 15,
                  borderRadius: 5,
                  topMargin: 14,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            width: 150,
            height: 110,
            margin: const EdgeInsets.only(
              left: horizontalScreenPadding,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseShimmer(width: 60, height: 50, borderRadius: 5),
                BaseShimmer(
                  width: 100,
                  height: 15,
                  borderRadius: 5,
                  topMargin: 14,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            width: 150,
            height: 110,
            margin: const EdgeInsets.only(
              left: horizontalScreenPadding,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseShimmer(width: 60, height: 50, borderRadius: 5),
                BaseShimmer(
                  width: 100,
                  height: 15,
                  borderRadius: 5,
                  topMargin: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
