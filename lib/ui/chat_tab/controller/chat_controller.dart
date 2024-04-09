import 'dart:convert';
import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/utils/get_storage.dart';
import 'package:binbeardriver/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController{
  ScrollController scrollController = ScrollController();
  IO.Socket? socket;
  @override
  void onInit() {
    // scrollToEnd();
    super.onInit();
  }


  scrollToEnd() {
    Future.delayed(const Duration(milliseconds: 0), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
    });
  }

  connectSocket({required String receiverId, required String schoolId}) {
    socket = IO.io(ApiEndPoints().socketUrl, IO.OptionBuilder().setTransports(['websocket']).build())..connect();
    socket?.on('connect', (_) {
      socket?.emit("CONNECT", BaseStorage.read(StorageKeys.userId, showLog: false)??"");
      socket?.on('THREADS_LIST_RESPONSE', (res) {
        print("chat list response ${res}");
        var ress = jsonDecode(res);
      });
    });

    socket?.onDisconnect((_) {
      print("Socket Disconnect");
      // connectSocket(receiverId: receiverId, schoolId: schoolId);
    });
    socket?.onConnectError((_) {
      print("Socket Connection Error: $_");
      // connectSocket();
    });
    socket?.on('error', (data) {
      print(data+"_________");
    });
  }

  // sendMessage(receiverId, String message, String type) async {
  //   final String userId = await BaseSharedPreference().getString(SpKeys().userId);
  //   try {
  //     socket?.emitWithAck("NEW_MESSAGE", {
  //       "roomId": joinRoomData["data"]["roomId"],
  //       "senderId": userId,
  //       "receiverId": receiverId,
  //       "message": message,
  //       "type": type
  //     }, ack: (data) {
  //       print("NEW_MESSAGE:- $data");
  //     });
  //     socket?.on("NEW_MESSAGE_RESPONSE", (data) {
  //       print("NEW_MESSAGE_RESPONSE:- $data");
  //       if (jsonDecode(data)['status'] == true) {
  //         socket?.emitWithAck("CHAT_DETAIL_NEW",{joinRoomData["data"]["roomId"], userId,receiverId}, ack: (data) {
  //           print("CHAT_DETAIL_NEW:- $data");
  //         });
  //       } else {
  //         baseToast(message: (jsonDecode(data)['message'] ?? ""));
  //       }
  //     });
  //   }catch(_){
  //     print("Exception....$_....");
  //   }
  // }
}