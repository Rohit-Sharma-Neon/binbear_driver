import 'package:binbeardriver/ui/base_components/animated_column.dart';
import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_no_data.dart';
import 'package:binbeardriver/ui/base_components/base_scaffold_background.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomisedGreyErrorScreen extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  const CustomisedGreyErrorScreen({super.key, required this.errorDetails});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        appBar: const BaseAppBar(),
        body: Center(
          child: AnimatedColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BaseNoData(
                message: kDebugMode ? errorDetails.summary.toString() : "We encountered an error and we've notified our engineering team about it. Sorry for the inconvenience caused.",
              )
            ],
          ),
        ),
      ),
    );
  }
}
