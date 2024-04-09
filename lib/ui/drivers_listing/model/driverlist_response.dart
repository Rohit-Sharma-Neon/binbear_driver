class DriverList {
  dynamic success;
  List<DriverData>? data;
  dynamic message;

  DriverList({this.success, this.data, this.message});

  DriverList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DriverData>[];
      json['data'].forEach((v) {
        data!.add(DriverData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class DriverData {
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
  dynamic bookingIds;


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
        this.updatedAt,
        this.bookingIds});

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
     bookingIds = json['booking_ids'];
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
    data['booking_ids'] = bookingIds;
    return data;
  }
}
