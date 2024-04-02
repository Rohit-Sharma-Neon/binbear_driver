class DriverList {
  bool? success;
  List<DriverData>? data;
  String? message;

  DriverList({this.success, this.data, this.message});

  DriverList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DriverData>[];
      json['data'].forEach((v) {
        data!.add(new DriverData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class DriverData {
  int? id;
  String? name;
  Null? middleName;
  Null? lastName;
  String? email;
  String? mobile;
  Null? stripeAccountId;
  Null? dob;
  Null? gender;
  int? isOnline;
  Null? countryCode;
  Null? otp;
  String? token;
  Null? profile;
  Null? bio;
  int? roleId;
  int? serviceProviderId;
  Null? businessName;
  Null? idProof;
  int? isVerify;
  int? adminApproval;
  int? status;
  int? binbearStatus;
  Null? binbearCurrentBooking;
  int? isSendNotification;
  String? emailVerifiedAt;
  int? phoneVerifiedAt;
  String? deviceToken;
  Null? socketId;
  String? createdAt;
  String? updatedAt;

  DriverData(
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

  DriverData.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['stripe_account_id'] = this.stripeAccountId;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['is_online'] = this.isOnline;
    data['country_code'] = this.countryCode;
    data['otp'] = this.otp;
    data['token'] = this.token;
    data['profile'] = this.profile;
    data['bio'] = this.bio;
    data['role_id'] = this.roleId;
    data['service_provider_id'] = this.serviceProviderId;
    data['business_name'] = this.businessName;
    data['id_proof'] = this.idProof;
    data['is_verify'] = this.isVerify;
    data['admin_approval'] = this.adminApproval;
    data['status'] = this.status;
    data['binbear_status'] = this.binbearStatus;
    data['binbear_current_booking'] = this.binbearCurrentBooking;
    data['is_send_notification'] = this.isSendNotification;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['device_token'] = this.deviceToken;
    data['socket_id'] = this.socketId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
