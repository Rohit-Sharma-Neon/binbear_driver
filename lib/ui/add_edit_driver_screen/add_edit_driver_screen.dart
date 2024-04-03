
import 'package:binbeardriver/ui/base_components/base_page_sub_title.dart';
import 'package:binbeardriver/ui/base_components/base_page_title.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utils/base_functions.dart';
import '../base_components/animated_column.dart';
import '../base_components/base_app_bar.dart';
import '../base_components/base_button.dart';
import '../base_components/base_container.dart';
import '../base_components/base_scaffold_background.dart';
import '../base_components/base_textfield.dart';
import '../drivers_listing/model/driverlist_response.dart';
import 'controller/editdriver_controller.dart';

class AddEditDriverScreen extends StatefulWidget {
  final bool isEditing;
  final DriverData? driverData;
  const AddEditDriverScreen({super.key, required this.isEditing, this.driverData});

  @override
  State<AddEditDriverScreen> createState() => _AddEditDriverScreenState();
}

class _AddEditDriverScreenState extends State<AddEditDriverScreen> {
  EditDriverController controller = Get.put(EditDriverController());
@override
  void initState() {
  controller.nameController.text = widget.driverData?.name??"";
  controller.emailController.text = widget.driverData?.email??"";
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        appBar: const BaseAppBar(),
        body: SingleChildScrollView(
          child: AnimatedColumn(
            children: [
              BasePageTitle(
                topMargin: 0,
                title: "${widget.isEditing ? "Update" : "Add"} Binbear",
              ),
              const BasePageSubTitle(
                subTitle: "Lorem ipsum is a dummy text",
              ),
              BaseContainer(
                topMargin: 10,
                bottomPadding: 24,
                child: AnimatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BaseTextField(
                      controller: controller.nameController,
                      labelText: 'Name',
                      hintText: 'Enter Full Name',
                      textInputType: TextInputType.name,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: SvgPicture.asset(BaseAssets.icPerson),
                      ),
                    ),
                    BaseTextField(
                      topMargin: 18,
                      controller: controller.emailController,
                      labelText: 'Email Address',
                      hintText: 'Email Address',
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: SvgPicture.asset(BaseAssets.icEmail),
                      ),
                    ),
                    BaseTextField(
                      topMargin: 18,
                      controller:controller. passwordController,
                      labelText: 'Password',
                      hintText: 'Enter Password',
                      textInputType: TextInputType.visiblePassword,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: SvgPicture.asset(BaseAssets.icLock),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: SvgPicture.asset(BaseAssets.icEyeCrossed),
                      ),
                    ),
                    BaseButton(
                      topMargin: 24,
                      title: "Continue",
                      onPressed: () {
                   if (controller.nameController.text.trim().isEmpty) {
                 showSnackBar(message: "Please Enter Full Name");
                  }else if (controller.emailController.text.trim().isEmpty) {
                     showSnackBar(message: "Please Enter Email");
                   }else if (!GetUtils.isEmail(controller.emailController.text.trim())) {
                     showSnackBar(message: "Please Enter Valid Email");
                   }else if (controller.passwordController.text.trim().isEmpty) {
                     showSnackBar(message: "Please Enter Password");
                   }else if (controller.passwordController.text.trim().length < 8) {
                     showSnackBar(message: "Password Length Can't Be Less Than 8");
                   }else{
                     if(widget.isEditing){
                       controller.editDriver(widget.driverData?.id.toString()??"");
                     }else{
                       controller.addDriver();
                     }
                        }
                      },
                    ),
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
