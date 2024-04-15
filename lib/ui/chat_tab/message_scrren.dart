import 'dart:io';

import 'package:binbeardriver/ui/base_components/base_app_bar.dart';
import 'package:binbeardriver/ui/base_components/base_scaffold_background.dart';
import 'package:binbeardriver/ui/chat_tab/controller/message_controller.dart';
import 'package:binbeardriver/utils/base_assets.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:binbeardriver/ui/chat_tab/model/ticket_chat_model.dart';
class MessageScreen extends StatefulWidget {
  final String? name;
  final String? convenienceId;
  final String? senderId;
  final String bookingId;

  const MessageScreen({super.key, this.name, this.convenienceId, this.senderId, required this.bookingId});
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  MessageController messageController = Get.find<MessageController>();

  @override
  void initState() {
    Future.microtask(() {
      messageController.init();
      if(messageController.socket?.active == true){
        messageController.isLoading.value = true;
        messageController.socket?.emit("CHAT_LIST", {
          "senderId":messageController.userId?.toString()??"",
          "roomId":widget.convenienceId?.toString()??"",
          "page":1,
          "booking_id":widget.bookingId.toString(),
        });
      }else {
        messageController.socketInitialise(callback: () {
          messageController.isLoading.value = true;
          messageController.socket?.emit("CHAT_LIST", {
            "senderId":messageController.userId?.toString()??"",
            "roomId":widget.convenienceId?.toString()??"",
            "page":1,
            "booking_id":widget.bookingId.toString(),
          });
        });
      }
    });
    super.initState();
  }
  sendMsg(String? txt, type, file) {
    var mFile = type == "TEXT" ? '' : file;
    //messageController.socket?.emit('SEND_MESSAGE',{messageController.userId, "1", widget.convenienceId, txt, type, mFile }, );
    messageController.socket?.emit('SEND_MESSAGE',{"senderId":messageController.userId,"receiveId":widget.senderId?.toString()??"","roomId":widget.convenienceId,"message":txt,"messageType": type,"messageFile": mFile,"tipId":"0"}, );
  }

  // sendImage(int val) async {
  //   if(val == 0)
  //     {
  //       final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //       if(image != null)
  //         {
  //           file = File(image.path);
  //
  //           var v = await context.read<CommonProvider>().fileUpload(file: file);
  //           if(v != null)
  //             {
  //               // print("object :: $v");
  //               // print("API Response type :: ${v.data?.image}");
  //               // print("API Response type :: ${v.data?.type}");
  //               sendMsg("", v.data?.type.toString(), v.data?.image.toString());
  //             }
  //           // print("object image Gallery :: $image");
  //         }
  //     }
  //   else
  //     {
  //       final image = await ImagePicker().pickImage(source: ImageSource.camera);
  //       if(image != null)
  //       {
  //         file = File(image.path);
  //         if(context.mounted) {
  //           var v = await context.read<CommonProvider>().fileUpload(file: file);
  //           if (v != null) {
  //             sendMsg("", v.data?.type.toString(), v.data?.image.toString());
  //           }
  //         }
  //         if (kDebugMode) {
  //           print("object image Camera :: $image");
  //         }
  //       }
  //     }
  // }

  @override
  void dispose() {
    messageController.socket?.disconnect();
    messageController.socket?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        appBar: const BaseAppBar(title: "Chat", contentColor: Colors.white, fontWeight: FontWeight.w600, titleSize: 20,),
        resizeToAvoidBottomInset: true,
        body: Obx((){
          return messageController.isLoading.value
              ? const Center(
            child: SizedBox(
              height: 30, width: 30,
              child: CircularProgressIndicator(),
            ),
          )
              : (messageController.chatList ?? []).isEmpty
              ? const Center(
            child: Text("No chats available.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ) : GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                controller: messageController.listController,
                shrinkWrap: true,
                itemCount: messageController.chatList?.length ?? 0,
                itemBuilder: (context, index) => item(messageController.chatList?[index]),
              ),
            ),
          );}),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.only(bottom: 5, top: 5),
            margin: const EdgeInsets.only(bottom: 2),
            color: Colors.white,
            child: TextField(
              controller: messageController.controller,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
              minLines: 1,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Type here".tr,
                hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 14),
                counterStyle: const TextStyle(color: Colors.transparent, fontSize: 0),
                counterText: null,
                counter: null,
                prefixIcon: GestureDetector(
                  onTap: () {
                    triggerHapticFeedback();
                    showMediaPicker().then((value) {
                      if ((value?.path??"").isNotEmpty) {
                        messageController.getUploadUrl(selectedImage: value??File("")).then((value) {
                          if (value.isNotEmpty) {
                            triggerHapticFeedback();
                            sendMsg("", "IMAGE", value);
                          }
                        });
                      }
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10, left: 15),
                    child: Icon(Icons.attach_file_outlined, size: 20),
                  ),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    if(messageController.controller.text.isNotEmpty) {
                      triggerHapticFeedback();
                      sendMsg(messageController.controller.text, "TEXT", "");
                      messageController.controller.clear();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 15, left: 25, top: 10, bottom: 10,
                    ),
                    child: SvgPicture.asset(BaseAssets.icSend),
                  ),
                ),
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  addMsg(){
    if(messageController.controller.text.isNotEmpty){
      setState(() {
        messageController.controller.clear();
        scrollToMaxExtent();
      });
    }
  }
  void scrollToMaxExtent() {
    var list =  messageController.chatList ;
    if((list ?? []).isNotEmpty)
    {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        messageController.listController!.animateTo(
          messageController.listController!.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
      });
    }

  }
  item(DataList? data) {
    return (data?.fromId?.toString()??'') == (messageController.userId?.toString()??"") ? right(data) : left(data);
  }

  left(DataList? data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            data?.fileType == "IMAGE"
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: () {
                  // Photo View
                  // mDialog(context, PhotoViewDialog(url: data.file!));
                },
                child: SizedBox(
                    height: MediaQuery.of(context).size.width / 2.5,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Image.network(
                      data!.file!  ?? '',
                      fit: BoxFit.cover,
                    )
                ),
              ),
            )
                : Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 100, minHeight: 40),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xffDE875A),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(data?.message ?? '', style: const TextStyle(fontSize: 15, color: Colors.white),),
            ),
            Text('${formatDateFromString(data?.createdAt, input: inFormat, output: time)}', style: const TextStyle(fontSize: 10, color: Colors.white),),
            const SizedBox(height: 10,),
          ],
        ),
      ],
    );
  }

  right(DataList? data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            data?.fileType == "IMAGE"
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: () {
                  // PhotoView
                  // mDialog(context, PhotoViewDialog(url: data.file!));
                },
                child: SizedBox(
                    height: MediaQuery.of(context).size.width / 2.5,
                    width: MediaQuery.of(context).size.width / 1.5,

                    child:
                    Image.network(
                      data?.file  ?? '',
                      fit: BoxFit.cover,
                    )

                ),
              ),
            )
                :
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 100, minHeight: 40),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xffFBE6D3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(data?.message ?? '', style: const TextStyle(fontSize: 15, color: Colors.black)),
            ),
            Text('${formatDateFromString(data?.createdAt, input: inFormat, output: time)}', style: const TextStyle(fontSize: 10, color: Colors.white),),
            const SizedBox(height: 10,),
          ],
        ),
      ],
    );
  }

}
