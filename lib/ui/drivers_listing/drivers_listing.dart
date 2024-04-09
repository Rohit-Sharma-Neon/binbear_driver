import 'package:binbeardriver/ui/add_edit_driver_screen/add_edit_driver_screen.dart';
import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_scaffold_background.dart';
import 'package:binbeardriver/ui/base_components/listview_builder_animation.dart';
import 'package:binbeardriver/ui/driver_exact_location/driver_exact_location_screen.dart';
import 'package:binbeardriver/ui/drivers_listing/controller/home_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:binbeardriver/ui/base_components/base_no_data.dart';
import 'package:binbeardriver/ui/base_components/drivers_listing_tile.dart';
import 'package:binbeardriver/ui/base_components/base_button.dart';
import 'package:binbeardriver/ui/onboardings/splash/controller/base_controller.dart';

class DriversListing extends StatefulWidget {
  const DriversListing({super.key});

  @override
  State<DriversListing> createState() => _DriversListingState();
}

class _DriversListingState extends State<DriversListing> {
  DriverListingController controller =Get.put(DriverListingController());
  BaseController homeTabController = Get.find<BaseController>();
@override
  void initState() {
    // TODO: implement initState
  homeTabController.driverList();
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
          child: Obx(() => (homeTabController.listDriver?.length??0) == 0? const BaseNoData(textColor: Colors.white, message: "No Data Found!",) : ListView.builder(
            itemCount: homeTabController.listDriver?.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              return ListviewBuilderAnimation(
                index: index,
                child: DriversListingTile(
                  title: homeTabController.listDriver![index].name.toString(),
                  isChecked: false,
                  showEditDeleteButtons: true,
                  onTap: () {
                    Get.to(() => DriverExactLocationScreen(latLng: controller.testingLatLngList[index],
                                driverData:
                                    homeTabController.listDriver?[index],
                              ));
                  },
                  onEdit: (){
                    Get.to(() =>  AddEditDriverScreen(isEditing: true,driverData: homeTabController.listDriver?[index],));
                  },
                  onDelete: (){
                    homeTabController.deleteDriver(
                      homeTabController.listDriver?[index].id,index
                    );
                  },
                ),
              );
            },
          ),
        )),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: horizontalScreenPadding, vertical: 14),
          width: double.infinity,
          color: Colors.white,
          child: BaseButton(
            title: '+ Add New Binbear',
            onPressed: (){
              Get.to(() => const AddEditDriverScreen(isEditing: false,));
            },
          ),
        ),
      ),
    );
  }
}
