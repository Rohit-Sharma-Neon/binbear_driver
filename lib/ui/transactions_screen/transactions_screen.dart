import 'package:binbeardriver/ui/base_components/animated_column.dart';
import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_container.dart';
import 'package:binbeardriver/ui/base_components/base_scaffold_background.dart';
import 'package:binbeardriver/ui/base_components/base_text.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
        child: Scaffold(
          appBar: const BaseAppBar(
            title: "Transactions",
            contentColor: Colors.white,
            titleSize: 19,
            titleSpacing: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalScreenPadding),
            child: Column(
              children: [
                BaseContainer(
                  borderRadius: 18,
                  leftPadding: 18,
                  topPadding: 14,
                  bottomMargin: 0,
                  bottomPadding: 14,
                  border: Border.all(width: 1.5, color: BaseColors.secondaryColor),
                  child: const Row(
                    children: [
                      Expanded(
                        child: BaseText(
                          value: "Monthly Total Compensation",
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_rounded, size: 33,)
                    ],
                  ),
                ),
                const BaseContainer(
                  topMargin: 18,
                  bottomMargin: 0,
                  borderRadius: 18,
                  leftPadding: 18,
                  topPadding: 14,
                  bottomPadding: 14,
                  child: Column(
                    children: [
                      BaseText(
                        value: "Total Balance",
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      BaseText(
                        value: "\$ 1200",
                        fontSize: 36,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  )
                ),
                Expanded(
                  child: BaseContainer(
                    topMargin: 18,
                    borderRadius: 18,
                    bottomMargin: 20,
                    leftPadding: 18,
                    rightPadding: 18,
                    topPadding: 14,
                    bottomPadding: 14,
                    child: ListView.builder(
                          itemCount: 8,
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BaseText(
                                  value: "Payment Received",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                                BaseText(
                                  value: "\$ 1200",
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                            const BaseText(
                              topMargin: 7,
                              value: "Great job! Keep up the great work. You are truly appreciated!",
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                            const BaseText(
                              topMargin: 8,
                              value: "Today, 3:30 pm",
                              fontSize: 10,
                              color: Color(0xff30302E),
                              fontWeight: FontWeight.w400,
                            ),
                            Divider(
                              height: 23,
                              color: Colors.grey.shade400,
                            )
                          ],
                        );
                      }),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
