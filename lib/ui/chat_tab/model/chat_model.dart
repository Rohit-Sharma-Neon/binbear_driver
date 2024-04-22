class ChatModel {
  ChatModel({
      this.status, 
      this.message, 
      this.data,
  });

  ChatModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.success, 
      this.data, 
      this.message,});

  Data.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataList.fromJson(v));
      });
    }
    message = json['message'];
  }
  bool? success;
  List<DataList>? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }

}

class DataList {
  DataList({
    this.id,
    this.groupName,
    this.type,
    this.lastMessage,
    this.totalUnread,
    this.bookingId,
    this.updatedAt,
    this.chatuser,});

  DataList.fromJson(dynamic json) {
    id = json['id'];
    bookingId = json['booking_id'];
    groupName = json['group_name'];
    type = json['type'];
    lastMessage = json['last_message'];
    totalUnread = json['total_unread'];
    updatedAt = json['updated_at'];
    if (json['chatuser'] != null) {
      chatuser = [];
      json['chatuser'].forEach((v) {
        chatuser?.add(Chatuser.fromJson(v));
      });
    }
  }
  num? id;
  String? groupName;
  String? type;
  String? lastMessage;
  num? totalUnread;
  String? updatedAt;
  String? bookingId;
  List<Chatuser>? chatuser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['group_name'] = groupName;
    map['type'] = type;
    map['booking_id'] = bookingId;
    map['last_message'] = lastMessage;
    map['total_unread'] = totalUnread;
    map['updated_at'] = updatedAt;
    if (chatuser != null) {
      map['chatuser'] = chatuser?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Chatuser {
  Chatuser({
      this.id, 
      this.convenienceId, 
      this.userId, 
      this.getUser,});

  Chatuser.fromJson(dynamic json) {
    id = json['id'];
    convenienceId = json['convenience_id'];
    userId = json['user_id'];
    getUser = json['get_user'] != null ? GetUser.fromJson(json['get_user']) : null;
  }
  num? id;
  num? convenienceId;
  num? userId;
  GetUser? getUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['convenience_id'] = convenienceId;
    map['user_id'] = userId;
    if (getUser != null) {
      map['get_user'] = getUser?.toJson();
    }
    return map;
  }

}

class GetUser {
  GetUser({
      this.id, 
      this.email, 
      this.fullName, 
      this.mobileNo, 
      this.countryCode, 
      this.isOnline, 
      this.profileImage,});

  GetUser.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    fullName = json['full_name'];
    mobileNo = json['mobile_no'];
    countryCode = json['country_code'];
    isOnline = json['is_online'];
    profileImage = json['profile_image'];
  }
  num? id;
  String? email;
  String? fullName;
  String? mobileNo;
  String? countryCode;
  num? isOnline;
  dynamic profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['full_name'] = fullName;
    map['mobile_no'] = mobileNo;
    map['country_code'] = countryCode;
    map['is_online'] = isOnline;
    map['profile_image'] = profileImage;
    return map;
  }

}