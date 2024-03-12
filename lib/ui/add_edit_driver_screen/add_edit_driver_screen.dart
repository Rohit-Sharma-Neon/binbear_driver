import 'package:binbeardriver/ui/base_components/base_page_sub_title.dart';
import 'package:binbeardriver/ui/base_components/base_page_title.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../base_components/animated_column.dart';
import '../base_components/base_app_bar.dart';
import '../base_components/base_button.dart';
import '../base_components/base_container.dart';
import '../base_components/base_scaffold_background.dart';
import '../base_components/base_textfield.dart';

class AddEditDriverScreen extends StatefulWidget {
  final bool isEditing;
  const AddEditDriverScreen({super.key, required this.isEditing});

  @override
  State<AddEditDriverScreen> createState() => _AddEditDriverScreenState();
}

class _AddEditDriverScreenState extends State<AddEditDriverScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      nameController.text = "Peter Parker";
      emailController.text = "peter@gmail.com";
      passwordController.text = "peter1234";
    }else{
      nameController.clear();
      emailController.clear();
      passwordController.clear();
    }
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
                      controller: nameController,
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
                      controller: emailController,
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
                      controller: passwordController,
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
                      onPressed: (){
                        Get.back();
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
