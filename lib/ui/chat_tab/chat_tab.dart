import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_container.dart';
import 'package:binbeardriver/ui/base_components/base_scaffold_background.dart';
import 'package:binbeardriver/ui/base_components/base_text.dart';
import 'package:binbeardriver/ui/chat_tab/chating_screen.dart';
import 'package:binbeardriver/ui/chat_tab/controller/chat_controller.dart';
import 'package:binbeardriver/ui/manual_address/components/address_search_field.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {

  ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        appBar: const BaseAppBar(
          title: "Messages",
          showNotification: true,
          showDrawerIcon: true,
        ),
        body: BaseContainer(
          bottomMargin: horizontalScreenPadding,
          rightMargin: horizontalScreenPadding,
          leftMargin: horizontalScreenPadding,
          rightPadding: 0,
          leftPadding: 0,
          child: Column(
            children: [
              AddressSearchField(
                controller: TextEditingController(),
                onCloseTap: () {
                  setState(() {});
                },
                onChanged: (val) {},
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: 10,
                    itemBuilder: (context, index){
                      return Column(
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              Get.to(() => const ChattingScreen());
                            },
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(99),
                                  child: Image.network("",
                                    width: 60,
                                    height: 60,
                                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                      return const Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: horizontalScreenPadding, right: horizontalScreenPadding),
                                          child: Icon(Icons.broken_image_rounded),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      BaseText(
                                        value: "john",
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      BaseText(
                                        value: "Lorem ipsum dolor sit amet, elit.",
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Divider(color: Colors.grey)
                        ],
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
