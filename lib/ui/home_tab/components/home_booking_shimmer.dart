import 'package:binbeardriver/ui/base_components/base_shimmer.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:binbeardriver/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeBookingShimmer extends StatelessWidget {
  const HomeBookingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            width: 300,
            height: 190,
            margin:
                const EdgeInsets.only(left: horizontalScreenPadding, right: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseShimmer(
                    width: double.maxFinite, height: 30, borderRadius: 5),
                BaseShimmer(
                    width: 120, height: 30, borderRadius: 5, topMargin: 14),
                BaseShimmer(
                    width: double.maxFinite,
                    height: 30,
                    borderRadius: 5,
                    topMargin: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BaseShimmer(
                      width: 130,
                      height: 35,
                      borderRadius: 12,
                      topMargin: 14,
                    ),
                    BaseShimmer(
                      width: 130,
                      height: 35,
                      borderRadius: 12,
                      topMargin: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            width: 300,
            height: 190,
            margin:
                const EdgeInsets.only(left: horizontalScreenPadding, right: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseShimmer(
                    width: double.maxFinite, height: 30, borderRadius: 5),
                BaseShimmer(
                    width: 120, height: 30, borderRadius: 5, topMargin: 14),
                BaseShimmer(
                    width: double.maxFinite,
                    height: 30,
                    borderRadius: 5,
                    topMargin: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BaseShimmer(
                      width: 130,
                      height: 35,
                      borderRadius: 12,
                      topMargin: 14,
                    ),
                    BaseShimmer(
                      width: 130,
                      height: 35,
                      borderRadius: 12,
                      topMargin: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            width: 300,
            height: 190,
            margin:
                const EdgeInsets.only(left: horizontalScreenPadding, right: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseShimmer(
                    width: double.maxFinite, height: 30, borderRadius: 5),
                BaseShimmer(
                    width: 120, height: 30, borderRadius: 5, topMargin: 14),
                BaseShimmer(
                    width: double.maxFinite,
                    height: 30,
                    borderRadius: 5,
                    topMargin: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BaseShimmer(
                      width: 130,
                      height: 35,
                      borderRadius: 12,
                      topMargin: 14,
                    ),
                    BaseShimmer(
                      width: 130,
                      height: 35,
                      borderRadius: 12,
                      topMargin: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
