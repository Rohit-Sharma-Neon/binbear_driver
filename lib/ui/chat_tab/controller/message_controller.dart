import 'dart:convert';
import 'dart:io';
import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/ui/chat_tab/model/chat_model.dart';
import 'package:binbeardriver/utils/get_storage.dart';
import 'package:binbeardriver/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:binbeardriver/ui/chat_tab/model/SentMessageUpdateModel.dart';
import 'package:binbeardriver/ui/chat_tab/model/ticket_chat_model.dart' as tcm;

class MessageController extends GetxController {
  RxList<tcm.DataList>? chatList = <tcm.DataList>[].obs;
  RxBool isLoading = false.obs;
  TextEditingController controller = TextEditingController();
  ScrollController? listController = ScrollController();
  File? file;

  RxBool chatUserLoading = false.obs;
  IO.Socket? socket;

  Rx<ChatModel> model = ChatModel().obs;

  init(){
    chatList?.clear();
  }

  addDataAll(List<tcm.DataList> value){
    chatList?.addAll(value.reversed);
    chatList?.refresh();
  }

  addData(tcm.DataList value){
    chatList?.add(value);
    chatList?.refresh();
  }

  get userId  => BaseStorage.read(StorageKeys.userId) ?? '';

  socketInitialise({Function? callback}) {
    chatUserLoading.value = true;

    socket = IO.io(
        ApiEndPoints().socketUrl,
        IO.OptionBuilder().setTransports(['websocket']).build())..connect();

    socket?.on('connect', (_) {
      print('Connected to server $userId');
      socket?.emit("CONNECT", userId);
      callback?.call();
    });

    socket?.on('THREADS_LIST_RESPONSE', (res) {
      print("chat list response ${res}");
      var ress = jsonDecode(res);
      ChatModel model  = ChatModel.fromJson(ress);
      if(model.status ==true){
        this.model.value = model;
      }
      chatUserLoading.value = false;
    });

    socket?.on('CHAT_LIST_RESPONSE', (res) {
      //print("chat list response ${res}"),
      print("response Chat List =>>>> ${res}");
      var ress = jsonDecode(res);
      tcm.TicketChatModel model  = tcm.TicketChatModel.fromJson(ress);

      if(model.data?.data?.data != null) {
        isLoading.value = false;
        addDataAll(model.data!.data!.data!);
        scrollToMaxExtent();
        // chatList.addAll(model.data!.data!.data!);
        /*WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<TicketProvider>().;
          setState(() {
            isLoading = false;
          });
          scrollToMaxExtent();
        });*/
      }
    });


    socket?.on('SEND_MESSAGE_RESPONSE', (res)  {
      //provider.refresh();
      print("SEND_MESSAGE_RESPONSE =>>>> ${res}");
      var ress = jsonDecode(res);
      SentMessageUpdateModel model = SentMessageUpdateModel.fromJson(ress);
      print("SentMessageUpdateModel :: ${model}");
      if(model.data?.data != null) {
        addData(model.data!.data!);
        scrollToMaxExtent();
      }
    });

  }

  void scrollToMaxExtent() {
    if(listController != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          listController!.animateTo(
            listController!.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
          );
        });
    }

  }

  emitThreadList(){
    socket?.emit("THREADS_LIST", {"senderId" : userId});
  }

  disposeSocket(){
    socket?.disconnected;
    socket?.dispose();
  }
}