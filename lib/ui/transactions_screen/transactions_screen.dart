import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_container.dart';
import 'package:binbeardriver/ui/base_components/base_scaffold_background.dart';
import 'package:binbeardriver/ui/base_components/base_text.dart';
import 'package:binbeardriver/utils/base_colors.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:binbeardriver/ui/base_components/base_no_data.dart';
import 'package:binbeardriver/ui/base_components/smart_refresher_base_header.dart';
import 'package:binbeardriver/ui/transactions_screen/components/transection_shimmer.dart';
import 'package:binbeardriver/ui/transactions_screen/controller/transaction_controller.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  TransactionController controller = Get.put( TransactionController());

  @override
  void initState() {
    // TODO: implement initState
    controller.getTransactionHistory();
    super.initState();
  }
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
                  child: DropdownButton<String>(
                    hint: const Text('Please Select Month'),
                    value: controller.dropdownValue,
                    onChanged: (String? value) {
                      setState(() {
                        controller.dropdownValue = value!;
                        controller.getTransactionHistory();
                      });
                    },
                    underline: const SizedBox(),
                    isExpanded: true,
                    style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.black),
                    selectedItemBuilder: (BuildContext context) {
                      return controller.options.map((String value) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                           controller.dropdownValue ?? '',
                          ),
                        );
                      }).toList();
                    },
                    items: controller.options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(fontSize: 15)),
                      );
                    }).toList(),
                  ),
                ),
                Obx(() => BaseContainer(
                    topMargin: 18,
                    bottomMargin: 0,
                    borderRadius: 18,
                    leftPadding: 18,
                    topPadding: 14,
                    bottomPadding: 14,
                    child: Column(
                      children: [
                        const BaseText(
                          value: "Total Balance",
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        BaseText(
                          value:"\$ ${double.parse(controller.totalPayment?.value ?? "0").toStringAsFixed(2)}" ,
                          fontSize: 36,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    )
                  ),
                ),
                Expanded(
                  child:Obx(() => BaseContainer(
                    topMargin: 18,
                    borderRadius: 18,
                    bottomMargin: 20,
                    leftPadding: 18,
                    rightPadding: 18,
                    topPadding: 14,
                    bottomPadding: 14,
                    child: SmartRefresher(
                      controller: controller.refreshController,
                      header:  const SmartRefresherBaseHeader(),
                      onRefresh: (){
                        controller.getTransactionHistory();
                      },
                      child: controller.isTransactionLoading.value
                          ? const TransactionShimmer()
                          : (controller.transactionData?.length??0) == 0 ? const BaseNoData(textColor: Colors.grey, message: "No Transactions Found!",) :ListView.builder(
                          itemCount: controller.transactionData?.length??0,
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                 Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const BaseText(
                                  value: "Payment Received",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                                BaseText(
                                  value: "\$ ${controller.transactionData?[index].serviceProviderPayment ??""}",
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                             BaseText(
                               topMargin: 7,
                               value: controller.transactionData?[index].title.toString() ?? "",
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                            Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                              children: [
                                 BaseText(
                                  topMargin: 8,
                                  value: formatDateTime(controller.transactionData?[index].createdAt.toString()?? ""),
                                  fontSize: 10,
                                  color: const Color(0xff30302E),
                                  fontWeight: FontWeight.w400,
                                ),
                                // BaseText(
                                //   topMargin: 8,
                                //   value:controller.transactionData?[index].id.toString() ?? "",
                                //   fontSize: 18,
                                //   color: const Color(0xff30302E),
                                //   fontWeight: FontWeight.w600,
                                // ),
                              ],
                            ),
                            Divider(
                              height: 23,
                              color: Colors.grey.shade400,
                            )
                          ],
                        );
                      }),
                  ),
                  ) ),
                )],
            ),
          ),
        ),
    );
  }
}
