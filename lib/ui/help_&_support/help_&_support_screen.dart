import 'package:binbeardriver/ui/base_components/animated_column.dart';
import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_button.dart';
import 'package:binbeardriver/ui/base_components/base_container.dart';
import 'package:binbeardriver/ui/base_components/base_scaffold_background.dart';
import 'package:binbeardriver/ui/chat_tab/chat_tab.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base_components/base_text.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
        child: Scaffold(
          appBar: const BaseAppBar(
            title: "Help & Support",
            titleSize: 20,
            titleSpacing: 0,
            contentColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: AnimatedColumn(
              children: [
                BaseContainer(
                  rightPadding: 25,
                  leftPadding: 25,
                  borderRadius: 13,
                  bottomPadding: 3,
                  bottomMargin: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const BaseText(
                        value: "FAQs",
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ExpansionTile(
                                shape: const Border(),
                                onExpansionChanged: (val){triggerHapticFeedback();},
                                tilePadding: EdgeInsets.zero,
                                childrenPadding: EdgeInsets.zero,
                                collapsedIconColor: BaseColors.secondaryColor,
                                iconColor: BaseColors.secondaryColor,
                                title: const BaseText(
                                  value: "Lorem Ipsum?",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                                children: const [
                                  BaseText(
                                    value: "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                    bottomMargin: 19,
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: index != 2,
                                child: Container(
                                  width: double.infinity,
                                  height: 1.3,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.grey.withOpacity(0.01),
                                        Colors.grey.shade600.withOpacity(1.0),
                                        Colors.grey.withOpacity(0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                BaseContainer(
                  topMargin: 18,
                  rightPadding: 25,
                  leftPadding: 25,
                  borderRadius: 13,
                  bottomPadding: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const BaseText(
                        value: "Still have a\nquery?",
                        fontSize: 28,
                        textAlign: TextAlign.center,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      BaseButton(
                        topMargin: 26,
                        bottomMargin: 20,
                        title: "Chat With Us",
                        onPressed: (){
                          Get.to(() => const ChatTab());
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
