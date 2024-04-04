import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/drivers_listing_tile.dart';
import 'package:binbeardriver/ui/base_components/base_button.dart';
import 'package:binbeardriver/ui/base_components/base_scaffold_background.dart';
import 'package:binbeardriver/ui/base_components/listview_builder_animation.dart';
import 'package:binbeardriver/ui/onboardings/splash/controller/base_controller.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class AssignJobManuallyScreen extends StatefulWidget {
  const AssignJobManuallyScreen({super.key, required this.bookingId});
final String bookingId;
  @override
  State<AssignJobManuallyScreen> createState() => _AssignJobManuallyScreenState();
}

class _AssignJobManuallyScreenState extends State<AssignJobManuallyScreen> {

  BaseController controller = Get.find<BaseController>();

  @override
  void initState() {
    // TODO: implement initState
    controller.driverList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        appBar: const BaseAppBar(
          title: "Assign Job",
          contentColor: Colors.white,
          titleSize: 19,
          titleSpacing: 0,
        ),
        body: AnimationLimiter(
          child:Obx(() =>  ListView.builder(
              itemCount: controller.listDriver?.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return ListviewBuilderAnimation(
                  index: index,
                  child:Obx(()=>DriversListingTile(
                    title: controller.listDriver![index].name.toString(),
                    isChecked: controller.selectedDriverIndex.value == index,
                    onTap: () {
                      triggerHapticFeedback();
                      controller.selectedDriverIndex.value = index;
                    },
                  ),
                )
                ); },

                    ),
          )),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: horizontalScreenPadding, vertical: 14),
          width: double.infinity,
          color: Colors.white,
          child: BaseButton(
            title: 'Assign',
            onPressed: (){
              controller.assignBooking(
                controller.listDriver?[controller.selectedDriverIndex.value].id.toString() ?? "",
                widget.bookingId,
              );
            },
          ),
        ),
      ),
    );
  }
}
