class HelpSupportResponse {
  dynamic success;
  HelpSupportData? data;
  dynamic message;

  HelpSupportResponse({this.success, this.data, this.message});

  HelpSupportResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? HelpSupportData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class HelpSupportData {
  User? user;
  List<Faq>? faq;

  HelpSupportData({this.user, this.faq});

  HelpSupportData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['faq'] != null) {
      faq = <Faq>[];
      json['faq'].forEach((v) {
        faq!.add(Faq.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (faq != null) {
      data['faq'] = faq!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  dynamic id;
  dynamic name;
  dynamic middleName;
  dynamic lastName;
  dynamic email;
  dynamic mobile;
  dynamic stripeAccountId;
  dynamic dob;
  dynamic gender;
  dynamic isOnline;
  dynamic countryCode;
  dynamic otp;
  dynamic token;
  dynamic profile;
  dynamic bio;
  dynamic roleId;
  dynamic serviceProviderId;
  dynamic businessName;
  dynamic roomId;
  dynamic idProof;
  dynamic isVerify;
  dynamic adminApproval;
  dynamic status;
  dynamic binbearStatus;
  dynamic binbearCurrentBooking;
  dynamic isSendNotification;
  dynamic emailVerifiedAt;
  dynamic phoneVerifiedAt;
  dynamic deviceToken;
  dynamic socketId;
  dynamic createdAt;
  dynamic updatedAt;
  ReceiverId? receiverId;

  User(
      {this.id,
        this.name,
        this.middleName,
        this.lastName,
        this.email,
        this.mobile,
        this.stripeAccountId,
        this.dob,
        this.gender,
        this.isOnline,
        this.countryCode,
        this.otp,
        this.token,
        this.profile,
        this.bio,
        this.roleId,
        this.serviceProviderId,
        this.businessName,
        this.roomId,
        this.idProof,
        this.isVerify,
        this.adminApproval,
        this.status,
        this.binbearStatus,
        this.binbearCurrentBooking,
        this.isSendNotification,
        this.emailVerifiedAt,
        this.phoneVerifiedAt,
        this.deviceToken,
        this.socketId,
        this.createdAt,
        this.updatedAt,
        this.receiverId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    stripeAccountId = json['stripe_account_id'];
    dob = json['dob'];
    gender = json['gender'];
    isOnline = json['is_online'];
    countryCode = json['country_code'];
    otp = json['otp'];
    token = json['token'];
    profile = json['profile'];
    bio = json['bio'];
    roleId = json['role_id'];
    serviceProviderId = json['service_provider_id'];
    businessName = json['business_name'];
    roomId = json['room_id'];
    idProof = json['id_proof'];
    isVerify = json['is_verify'];
    adminApproval = json['admin_approval'];
    status = json['status'];
    binbearStatus = json['binbear_status'];
    binbearCurrentBooking = json['binbear_current_booking'];
    isSendNotification = json['is_send_notification'];
    emailVerifiedAt = json['email_verified_at'];
    phoneVerifiedAt = json['phone_verified_at'];
    deviceToken = json['device_token'];
    socketId = json['socket_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    receiverId = json['receiver_id'] != null
        ? ReceiverId.fromJson(json['receiver_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['stripe_account_id'] = stripeAccountId;
    data['dob'] = dob;
    data['gender'] = gender;
    data['is_online'] = isOnline;
    data['country_code'] = countryCode;
    data['otp'] = otp;
    data['token'] = token;
    data['profile'] = profile;
    data['bio'] = bio;
    data['role_id'] = roleId;
    data['service_provider_id'] = serviceProviderId;
    data['business_name'] = businessName;
    data['room_id'] = roomId;
    data['id_proof'] = idProof;
    data['is_verify'] = isVerify;
    data['admin_approval'] = adminApproval;
    data['status'] = status;
    data['binbear_status'] = binbearStatus;
    data['binbear_current_booking'] = binbearCurrentBooking;
    data['is_send_notification'] = isSendNotification;
    data['email_verified_at'] = emailVerifiedAt;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['device_token'] = deviceToken;
    data['socket_id'] = socketId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (receiverId != null) {
      data['receiver_id'] = receiverId!.toJson();
    }
    return data;
  }
}

class ReceiverId {
  dynamic id;
  dynamic name;
  dynamic middleName;
  dynamic lastName;
  dynamic email;
  dynamic mobile;
  dynamic stripeAccountId;
  dynamic dob;
  dynamic gender;
  dynamic isOnline;
  dynamic countryCode;
  dynamic otp;
  dynamic token;
  dynamic profile;
  dynamic bio;
  dynamic roleId;
  dynamic serviceProviderId;
  dynamic businessName;
  dynamic roomId;
  dynamic idProof;
  dynamic isVerify;
  dynamic adminApproval;
  dynamic status;
  dynamic binbearStatus;
  dynamic binbearCurrentBooking;
  dynamic isSendNotification;
  dynamic emailVerifiedAt;
  dynamic phoneVerifiedAt;
  dynamic deviceToken;
  dynamic socketId;
  dynamic createdAt;
  dynamic updatedAt;

  ReceiverId(
      {this.id,
        this.name,
        this.middleName,
        this.lastName,
        this.email,
        this.mobile,
        this.stripeAccountId,
        this.dob,
        this.gender,
        this.isOnline,
        this.countryCode,
        this.otp,
        this.token,
        this.profile,
        this.bio,
        this.roleId,
        this.serviceProviderId,
        this.businessName,
        this.roomId,
        this.idProof,
        this.isVerify,
        this.adminApproval,
        this.status,
        this.binbearStatus,
        this.binbearCurrentBooking,
        this.isSendNotification,
        this.emailVerifiedAt,
        this.phoneVerifiedAt,
        this.deviceToken,
        this.socketId,
        this.createdAt,
        this.updatedAt});

  ReceiverId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    stripeAccountId = json['stripe_account_id'];
    dob = json['dob'];
    gender = json['gender'];
    isOnline = json['is_online'];
    countryCode = json['country_code'];
    otp = json['otp'];
    token = json['token'];
    profile = json['profile'];
    bio = json['bio'];
    roleId = json['role_id'];
    serviceProviderId = json['service_provider_id'];
    businessName = json['business_name'];
    roomId = json['room_id'];
    idProof = json['id_proof'];
    isVerify = json['is_verify'];
    adminApproval = json['admin_approval'];
    status = json['status'];
    binbearStatus = json['binbear_status'];
    binbearCurrentBooking = json['binbear_current_booking'];
    isSendNotification = json['is_send_notification'];
    emailVerifiedAt = json['email_verified_at'];
    phoneVerifiedAt = json['phone_verified_at'];
    deviceToken = json['device_token'];
    socketId = json['socket_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['stripe_account_id'] = stripeAccountId;
    data['dob'] = dob;
    data['gender'] = gender;
    data['is_online'] = isOnline;
    data['country_code'] = countryCode;
    data['otp'] = otp;
    data['token'] = token;
    data['profile'] = profile;
    data['bio'] = bio;
    data['role_id'] = roleId;
    data['service_provider_id'] = serviceProviderId;
    data['business_name'] = businessName;
    data['room_id'] = roomId;
    data['id_proof'] = idProof;
    data['is_verify'] = isVerify;
    data['admin_approval'] = adminApproval;
    data['status'] = status;
    data['binbear_status'] = binbearStatus;
    data['binbear_current_booking'] = binbearCurrentBooking;
    data['is_send_notification'] = isSendNotification;
    data['email_verified_at'] = emailVerifiedAt;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['device_token'] = deviceToken;
    data['socket_id'] = socketId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Faq {
  dynamic id;
  dynamic question;
  dynamic answer;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  Faq(
      {this.id,
        this.question,
        this.answer,
        this.status,
        this.createdAt,
        this.updatedAt});

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}