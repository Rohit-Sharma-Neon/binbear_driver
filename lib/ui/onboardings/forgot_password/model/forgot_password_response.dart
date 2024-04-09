// To parse this JSON data, do
//
//     final forgotPasswordResponse = forgotPasswordResponseFromJson(jsonString);

import 'dart:convert';

ForgotPasswordResponse forgotPasswordResponseFromJson(String str) =>
    ForgotPasswordResponse.fromJson(json.decode(str));

String forgotPasswordResponseToJson(ForgotPasswordResponse data) =>
    json.encode(data.toJson());

class ForgotPasswordResponse {
  bool? success;
  Data? data;
  String? message;

  ForgotPasswordResponse({
    this.success,
    this.data,
    this.message,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponse(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
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
  dynamic createdAt;
  dynamic updatedAt;

  Data({
    this.id,
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
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobile: json["mobile"],
        stripeAccountId: json["stripe_account_id"],
        dob: json["dob"],
        gender: json["gender"],
        isOnline: json["is_online"],
        countryCode: json["country_code"],
        otp: json["otp"],
        token: json["token"],
        profile: json["profile"],
        bio: json["bio"],
        roleId: json["role_id"],
        serviceProviderId: json["service_provider_id"],
        businessName: json["business_name"],
        idProof: json["id_proof"],
        isVerify: json["is_verify"],
        adminApproval: json["admin_approval"],
        status: json["status"],
        binbearStatus: json["binbear_status"],
        binbearCurrentBooking: json["binbear_current_booking"],
        isSendNotification: json["is_send_notification"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        phoneVerifiedAt: json["phone_verified_at"],
        deviceToken: json["device_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "middle_name": middleName,
        "last_name": lastName,
        "email": email,
        "mobile": mobile,
        "stripe_account_id": stripeAccountId,
        "dob": dob,
        "gender": gender,
        "is_online": isOnline,
        "country_code": countryCode,
        "otp": otp,
        "token": token,
        "profile": profile,
        "bio": bio,
        "role_id": roleId,
        "service_provider_id": serviceProviderId,
        "business_name": businessName,
        "id_proof": idProof,
        "is_verify": isVerify,
        "admin_approval": adminApproval,
        "status": status,
        "binbear_status": binbearStatus,
        "binbear_current_booking": binbearCurrentBooking,
        "is_send_notification": isSendNotification,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "phone_verified_at": phoneVerifiedAt,
        "device_token": deviceToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
