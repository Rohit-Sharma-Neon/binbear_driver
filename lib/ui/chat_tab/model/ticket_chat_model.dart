class TicketChatModel {
  TicketChatModel({
      this.status,
      this.message,
      this.data,});

  TicketChatModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  Data? data;


}

class Data {

  Data.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? DataPage.fromJson(json['data']) : null;
    message = json['message'];
  }
  bool? success;
  DataPage? data;
  String? message;


}

class DataPage {

  DataPage.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataList.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
  List<DataList>? data;
  num? currentPage;
  num? from;
  num? lastPage;
  num? perPage;
  num? to;
  num? total;


}

class DataList {

  DataList.fromJson(dynamic json) {
    id = json['id'];
    convenienceId = json['convenience_id'];
    chatUserId = json['chat_user_id'];
    fromId = json['from_id'];
    toId = json['to_id'];
    replayId = json['replay_id'];
    message = json['message'];
    file = json['file'];
    fileType = json['file_type'];
    isRead = json['is_read'];
    date = json['date'];
    time = json['time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    receiver = json['receiver'] != null ? Receiver.fromJson(json['receiver']) : null;
    //receiver = json['receiver'];
  }
  num? id;
  num? convenienceId;
  num? chatUserId;
  num? fromId;
  num? toId;
  num? replayId;
  String? message;
  String? file;
  String? fileType;
  String? isRead;
  String? date;
  String? time;
  String? createdAt;
  String? updatedAt;
  String? image;
  Sender? sender;
  Receiver? receiver;
}


class Receiver {

  Receiver.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    emailVerifiedAt = json['email_verified_at'];
    adminPassword = json['admin_password'];
    isBlock = json['is_block'];
    countryCode = json['country_code'];
    country = json['country'];
    apiToken = json['api_token'];
    emailOtp = json['email_otp'];
    mobileOtp = json['mobile_otp'];
    gender = json['gender'];
    otherGender = json['other_gender'];
    isVerified = json['is_verified'];
    isMobileVerified = json['is_mobile_verified'];
    profileImage = json['profile_image'];
    dob = json['dob'];
    bio = json['bio'];
    address = json['address'];
    deviceToken = json['device_token'];
    deviceType = json['device_type'];
    deviceId = json['device_id'];
    notificationIsOn = json['notification_is_on'];
    roleId = json['role_id'];
    isNew = json['is_new'];
    socialType = json['social_type'];
    socialId = json['social_id'];
    isOnline = json['is_online'];
    socketId = json['socket_id'];
    isGuest = json['is_guest'];
    isApproved = json['is_approved'];
    earning = json['earning'];
    wallet = json['wallet'];
    tempEmail = json['temp_email'];
    tempMobileNo = json['temp_mobile_no'];
    tempCountryCode = json['temp_country_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
  num? id;
  String? fullName;
  String? email;
  String? mobileNo;
  dynamic emailVerifiedAt;
  String? adminPassword;
  num? isBlock;
  String? countryCode;
  String? country;
  dynamic apiToken;
  String? emailOtp;
  String? mobileOtp;
  String? gender;
  String? otherGender;
  num? isVerified;
  num? isMobileVerified;
  String? profileImage;
  String? dob;
  dynamic bio;
  String? address;
  dynamic deviceToken;
  String? deviceType;
  dynamic deviceId;
  num? notificationIsOn;
  num? roleId;
  num? isNew;
  dynamic socialType;
  dynamic socialId;
  num? isOnline;
  String? socketId;
  num? isGuest;
  num? isApproved;
  dynamic earning;
  num? wallet;
  dynamic tempEmail;
  dynamic tempMobileNo;
  dynamic tempCountryCode;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

}

class Sender {


  Sender.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    emailVerifiedAt = json['email_verified_at'];
    adminPassword = json['admin_password'];
    isBlock = json['is_block'];
    countryCode = json['country_code'];
    country = json['country'];
    apiToken = json['api_token'];
    emailOtp = json['email_otp'];
    mobileOtp = json['mobile_otp'];
    gender = json['gender'];
    otherGender = json['other_gender'];
    isVerified = json['is_verified'];
    isMobileVerified = json['is_mobile_verified'];
    profileImage = json['profile_image'];
    dob = json['dob'];
    bio = json['bio'];
    address = json['address'];
    deviceToken = json['device_token'];
    deviceType = json['device_type'];
    deviceId = json['device_id'];
    notificationIsOn = json['notification_is_on'];
    roleId = json['role_id'];
    isNew = json['is_new'];
    socialType = json['social_type'];
    socialId = json['social_id'];
    isOnline = json['is_online'];
    socketId = json['socket_id'];
    isGuest = json['is_guest'];
    isApproved = json['is_approved'];
    earning = json['earning'];
    wallet = json['wallet'];
    tempEmail = json['temp_email'];
    tempMobileNo = json['temp_mobile_no'];
    tempCountryCode = json['temp_country_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
  num? id;
  String? fullName;
  String? email;
  String? mobileNo;
  dynamic emailVerifiedAt;
  String? adminPassword;
  num? isBlock;
  String? countryCode;
  dynamic country;
  dynamic apiToken;
  String? emailOtp;
  dynamic mobileOtp;
  String? gender;
  dynamic otherGender;
  num? isVerified;
  num? isMobileVerified;
  String? profileImage;
  String? dob;
  dynamic bio;
  dynamic address;
  String? deviceToken;
  String? deviceType;
  dynamic deviceId;
  num? notificationIsOn;
  num? roleId;
  num? isNew;
  dynamic socialType;
  dynamic socialId;
  num? isOnline;
  String? socketId;
  num? isGuest;
  num? isApproved;
  dynamic earning;
  num? wallet;
  dynamic tempEmail;
  dynamic tempMobileNo;
  dynamic tempCountryCode;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;


}

/*

class Sender {
  Sender({
      this.id,
      this.email,
      this.fullName,
      this.mobileNo,
      this.countryCode,
      this.isOnline,
      this.profileImage,});

  Sender.fromJson(dynamic json) {
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
  String? profileImage;

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

}*/
