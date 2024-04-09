import 'package:binbeardriver/ui/chat_tab/model/ticket_chat_model.dart';

class SentMessageUpdateModel {
  SentMessageUpdateModel({
      this.status, 
      this.message, 
      this.data,});

  SentMessageUpdateModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  Data? data;


}

class Data {
  Data({
      this.success, 
      this.data, 
      this.message,});

  Data.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? DataList.fromJson(json['data']) : null;
    message = json['message'];
  }
  bool? success;
  DataList? data;
  String? message;


}


