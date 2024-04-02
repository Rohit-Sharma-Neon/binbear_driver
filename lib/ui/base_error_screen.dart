import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_no_data.dart';
import 'package:binbeardriver/ui/base_components/base_scaffold_background.dart';
import 'package:flutter/material.dart';

class BaseErrorScreen extends StatelessWidget {
  final String? message;
  const BaseErrorScreen({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        appBar: const BaseAppBar(),
        body: Center(
          child: BaseNoData(
            message: message??"It seems that the device is rooted or jailbroken, so this application can't run on this device.",
          ),
        ),
      ),
    );
  }
}
