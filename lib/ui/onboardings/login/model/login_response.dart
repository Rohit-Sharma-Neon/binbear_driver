// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    bool? success;
    LoginData? data;
    String? message;

    LoginResponse({
        this.success,
        this.data,
        this.message,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"],
        data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
    };
}

class LoginData {
    User? user;
    bool? hasAddress;

    LoginData({
        this.user,
        this.hasAddress,
    });

    factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        hasAddress: json["has_address"],
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "has_address": hasAddress,
    };
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

    User({
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
        this.socketId,
        this.createdAt,
        this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
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
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        phoneVerifiedAt: json["phone_verified_at"],
        deviceToken: json["device_token"],
        socketId: json["socket_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
        "socket_id": socketId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
