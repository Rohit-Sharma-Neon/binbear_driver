import 'package:binbeardriver/ui/add_edit_driver_screen/add_edit_driver_screen.dart';
import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_scaffold_background.dart';
import 'package:binbeardriver/ui/base_components/listview_builder_animation.dart';
import 'package:binbeardriver/ui/driver_exact_location/driver_exact_location_screen.dart';
import 'package:binbeardriver/ui/home_tab/controller/home_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../utils/base_sizes.dart';
import '../base_components/drivers_listing_tile.dart';
import '../base_components/base_button.dart';
import '../onboardings/base_success_screen.dart';

class DriversListing extends StatefulWidget {
  const DriversListing({super.key});

  @override
  State<DriversListing> createState() => _DriversListingState();
}

class _DriversListingState extends State<DriversListing> {

  HomeTabController homeTabController = Get.find<HomeTabController>();

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
          child: ListView.builder(
            itemCount: homeTabController.driverNames.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              return ListviewBuilderAnimation(
                index: index,
                child: DriversListingTile(
                  title: homeTabController.driverNames[index],
                  isChecked: false,
                  showEditDeleteButtons: true,
                  onTap: () {
                    Get.to(() => DriverExactLocationScreen(latLng: homeTabController.testingLatLngList[index]));
                  },
                  onEdit: (){
                    Get.to(() => const AddEditDriverScreen(isEditing: true));
                  },
                  onDelete: (){},
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: horizontalScreenPadding, vertical: 14),
          width: double.infinity,
          color: Colors.white,
          child: BaseButton(
            title: '+ Add New Binbear',
            onPressed: (){
              Get.to(() => const AddEditDriverScreen(isEditing: false));
            },
          ),
        ),
      ),
    );
  }
}
