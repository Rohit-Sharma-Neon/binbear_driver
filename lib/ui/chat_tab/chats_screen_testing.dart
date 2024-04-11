import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_container.dart';
import 'package:binbeardriver/ui/chat_tab/controller/message_controller.dart';
import 'package:binbeardriver/ui/chat_tab/message_scrren.dart';
import 'package:binbeardriver/ui/chat_tab/model/chat_model.dart';
import 'package:binbeardriver/ui/manual_address/components/address_search_field.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_sizes.dart';
import 'package:binbeardriver/utils/get_storage.dart';
import 'package:binbeardriver/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsScreen extends StatefulWidget {
  final String? otherUserId;
  const ChatsScreen({super.key, this.otherUserId});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  MessageController messageController = Get.put(MessageController());
  @override
  void initState() {
    Future.microtask(() {
      if(messageController.socket?.active == true){
        messageController.emitThreadList();
      }else {
        messageController.socketInitialise(callback: () {
          messageController.emitThreadList();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    messageController.disposeSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BaseAppBar(
          title: "Message",
          contentColor: Colors.white,
          titleSize: 20,
          fontWeight: FontWeight.w600,
        ),
        body: BaseContainer(
          height: double.infinity,
          bottomMargin: horizontalScreenPadding,
          rightMargin: horizontalScreenPadding,
          leftMargin: horizontalScreenPadding,
          child: Obx((){
            List<DataList?>? data = messageController.model.value.data?.data ?? [];
            return Padding(
              padding: const EdgeInsets.only(top: 0, right: 8, left: 8),
              child: Column(
                children: [
                  AddressSearchField(
                    topMargin: 0,
                    rightMargin: 0,
                    leftMargin: 0,
                    bottomMargin: 10,
                    controller: TextEditingController(),
                    onCloseTap: () {
                      setState(() {});
                    },
                    onChanged: (val) {},
                  ),
                  Expanded(
                    child: (data ?? []).isNotEmpty ? ListView.builder(
                      itemCount: data.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var it = data[index];
                        var findUser = isUser(it?.chatuser?.first, BaseStorage.read(StorageKeys.userId)?.toString()??"");
                        return GestureDetector(
                          onTap: () {
                            var senderId = it?.chatuser?.where((element) => element.userId.toString() != messageController.userId.toString()).first.userId;
                            senderId;
                            Get.to(MessageScreen(
                              convenienceId: it?.chatuser?.last.convenienceId.toString(),
                              senderId: senderId.toString(),
                              bookingId: "",
                              // bookingId: controller.bookings?[index]?.id?.toString()??"",
                            ))?.then((value) {
                              messageController.emitThreadList();
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    color: Colors.grey.shade100,
                                    height: 45, width: 45,
                                    child: findUser ? it?.chatuser?.last.getUser?.profileImage != null ?
                                    Image.network(
                                      it?.chatuser?.last.getUser?.profileImage ?? '',
                                      height: 45,
                                      width: 45,
                                      fit: BoxFit.cover,
                                    ) : Image.asset(
                                      BaseAssets.icPerson,
                                      height: 45,
                                      width: 45,
                                      fit: BoxFit.cover,
                                    ) : it?.chatuser?.first.getUser?.profileImage != null ?
                                    Image.network(it?.chatuser?.first.getUser?.profileImage ?? '', height: 45, width: 45,fit: BoxFit.cover,)
                                        : Image.asset(BaseAssets.icPerson, height: 45, width: 45,fit: BoxFit.cover,),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(findUser
                                                ? it?.chatuser?.last.getUser?.fullName ?? ''
                                                : it?.chatuser?.first.getUser?.fullName ?? '',
                                                style: const TextStyle(fontSize: 15)),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(it?.updatedAt ?? '',
                                              style: const TextStyle(fontSize: 13)),
                                        ],
                                      ),
                                      Text(it?.lastMessage ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 14)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ) : const Center(child: Text("Data not Found")),
                  ),
                ],
              ),
            );
          },
          ),
        )
    );
  }

  bool isUser(Chatuser? first, String userId){
    return first?.userId.toString() == userId;
  }
}
