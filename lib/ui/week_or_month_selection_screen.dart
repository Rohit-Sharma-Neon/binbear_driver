import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_components/base_app_bar.dart';
import 'base_components/base_button.dart';
import 'base_components/base_list_checkbox.dart';
import 'base_components/base_page_sub_title.dart';
import 'base_components/base_page_title.dart';
import 'base_components/base_scaffold_background.dart';
import 'week_or_month_confirm_screen.dart';

class WeekOrMonthSelectionScreen extends StatefulWidget {

  const WeekOrMonthSelectionScreen({super.key});

  @override
  State<WeekOrMonthSelectionScreen> createState() => _WeekOrMonthSelectionScreenState();
}

class _WeekOrMonthSelectionScreenState extends State<WeekOrMonthSelectionScreen> {

  int selectedServiceIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        appBar: const BaseAppBar(),
        body: Column(
          children: [
            const BasePageTitle(
              topMargin: 0,
              title: "Can 2 Curb Service",
              bottomMargin: 0,
            ),
            const BasePageSubTitle(
              subTitle: "1x Can2curb service",
              bottomMargin: 45,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: servicesTitle.length,
                itemBuilder: (context, index){
                  return BaseListCheckbox(
                    imageUrl: BaseAssets.icServiceCalendar,
                    title: servicesTitle[index],
                    isChecked: selectedServiceIndex == index,
                    onTap: (){
                      triggerHapticFeedback();
                      setState(() {
                        selectedServiceIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: horizontalScreenPadding, vertical: 14),
              width: double.infinity,
              color: Colors.white,
              child: BaseButton(
                title: 'Next',
                onPressed: (){
                  Get.off(() => WeekOrMonthConfirmScreen(selectedServiceTitle: servicesTitle[selectedServiceIndex],));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  List<String> servicesTitle = [
    "Weekly Service",
    "Monthly Service",
  ];
}
