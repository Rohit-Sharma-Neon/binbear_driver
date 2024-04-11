// To parse this JSON data, do
//
//     final homeDataResponse = homeDataResponseFromJson(jsonString);

import 'dart:convert';

HomeDataResponse homeDataResponseFromJson(String str) =>
    HomeDataResponse.fromJson(json.decode(str));

String homeDataResponseToJson(HomeDataResponse data) =>
    json.encode(data.toJson());

class HomeDataResponse {
  bool? success;
  Data? data;
  String? message;

  HomeDataResponse({
    this.success,
    this.data,
    this.message,
  });

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      HomeDataResponse(
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
  List<Booking>? bookings;
  List<AllDriver>? allDrivers;
  dynamic totalBooking;
  dynamic totalEarning;

  Data({
    this.bookings,
    this.allDrivers,
    this.totalBooking,
    this.totalEarning,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookings: json["bookings"] == null
            ? []
            : List<Booking>.from(
                json["bookings"]!.map((x) => Booking.fromJson(x))),
        allDrivers: json["all_drivers"] == null
            ? []
            : List<AllDriver>.from(
                json["all_drivers"]!.map((x) => AllDriver.fromJson(x))),
        totalBooking: json["total_booking"],
        totalEarning: json["total_earning"],
      );

  Map<String, dynamic> toJson() => {
        "bookings": bookings == null
            ? []
            : List<dynamic>.from(bookings!.map((x) => x.toJson())),
        "all_drivers": allDrivers == null
            ? []
            : List<dynamic>.from(allDrivers!.map((x) => x.toJson())),
        "total_booking": totalBooking,
        "total_earning": totalEarning,
      };
}

class AllDriver {
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

  AllDriver({
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

  factory AllDriver.fromJson(Map<String, dynamic> json) => AllDriver(
        id: json["id"],
        name: json["name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobile: json["mobile"],
        stripeAccountId: json["stripe_account_id"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
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
        socketId: json["socket_id"],
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
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
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

class Booking {
  dynamic id;
  dynamic assignedProvider;
  dynamic assignedDriver;
  dynamic userId;
  dynamic addressId;
  dynamic categoryId;
  dynamic subCategoryId;
  dynamic noOfCane;
  dynamic basePrice;
  dynamic price;
  dynamic couponId;
  dynamic transactionId;
  dynamic serviceProviderPayment;
  dynamic adminPayment;
  dynamic status;
  dynamic assignStatus;
  dynamic serviceStatus;
  dynamic createdAt;
  dynamic updatedAt;
  PickupAddress? pickupAddress;
  UserDetail? userDetail;
  DriverDetails? driverDetail;
  dynamic distance;
  dynamic time;

  Booking({
    this.id,
    this.assignedProvider,
    this.assignedDriver,
    this.userId,
    this.addressId,
    this.categoryId,
    this.subCategoryId,
    this.noOfCane,
    this.basePrice,
    this.price,
    this.couponId,
    this.transactionId,
    this.serviceProviderPayment,
    this.adminPayment,
    this.status,
    this.assignStatus,
    this.serviceStatus,
    this.createdAt,
    this.updatedAt,
    this.pickupAddress,
    this.driverDetail,
    this.distance,
    this.time,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        assignedProvider: json["assigned_provider"],
        assignedDriver: json["assigned_driver"],
        userId: json["user_id"],
        addressId: json["address_id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        noOfCane: json["no_of_cane"],
        basePrice: json["base_price"],
        price: json["price"],
        couponId: json["coupon_id"],
        transactionId: json["transaction_id"],
        serviceProviderPayment: json["service_provider_payment"],
        adminPayment: json["admin_payment"],
        assignStatus: json["assign_status"],
        status: json["status"],
        serviceStatus: json["service_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        pickupAddress: json["pickup_address"] == null
            ? null
            : PickupAddress.fromJson(json["pickup_address"]),
    driverDetail: json["assigned_driver_details"] == null ? null : DriverDetails.fromJson(json["assigned_driver_details"]),
        distance: json["distance"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "assigned_provider": assignedProvider,
        "assigned_driver": assignedDriver,
        "user_id": userId,
        "address_id": addressId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "no_of_cane": noOfCane,
        "base_price": basePrice,
        "price": price,
        "coupon_id": couponId,
        "transaction_id": transactionId,
        "service_provider_payment": serviceProviderPayment,
        "admin_payment": adminPayment,
        "status": status,
        "assign_status": assignStatus,
        "service_status": serviceStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pickup_address": pickupAddress?.toJson(),
      "assigned_driver_details": driverDetail?.toJson(),
        "distance": distance,
        "time": time,
      };
}

class PickupAddress {
  dynamic id;
  dynamic userId;
  dynamic flatNo;
  dynamic apartment;
  dynamic description;
  dynamic lat;
  dynamic lng;
  dynamic homeType;
  dynamic fullAddress;
  dynamic isDeleted;
  dynamic isDefault;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  PickupAddress({
    this.id,
    this.userId,
    this.flatNo,
    this.apartment,
    this.description,
    this.lat,
    this.lng,
    this.homeType,
    this.fullAddress,
    this.isDeleted,
    this.isDefault,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory PickupAddress.fromJson(Map<String, dynamic> json) => PickupAddress(
        id: json["id"],
        userId: json["user_id"],
        flatNo: json["flat_no"],
        apartment: json["apartment"],
        description: json["description"],
        lat: json["lat"],
        lng: json["lng"],
        homeType: json["home_type"],
        fullAddress: json["full_address"],
        isDeleted: json["is_deleted"],
        isDefault: json["is_default"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "flat_no": flatNo,
        "apartment": apartment,
        "description": description,
        "lat": lat,
        "lng": lng,
        "home_type": homeType,
        "full_address": fullAddress,
        "is_deleted": isDeleted,
        "is_default": isDefault,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}



class UserDetail {
  dynamic  id;
  dynamic  name;
  dynamic middleName;
  dynamic lastName;
  dynamic  email;
  dynamic  mobile;
  dynamic  stripeAccountId;
  dynamic dob;
  dynamic gender;
  dynamic  isOnline;
  dynamic  countryCode;
  dynamic  otp;
  dynamic  token;
  dynamic profile;
  dynamic bio;
  dynamic  roleId;
  dynamic serviceProviderId;
  dynamic businessName;
  dynamic idProof;
  dynamic  isVerify;
  dynamic  adminApproval;
  dynamic  status;
  dynamic  binbearStatus;
  dynamic binbearCurrentBooking;
  dynamic  isSendNotification;
  dynamic  emailVerifiedAt;
  dynamic  phoneVerifiedAt;
  dynamic  deviceToken;
  dynamic socketId;
  dynamic  createdAt;
  dynamic  updatedAt;

  UserDetail({
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

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
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
        socketId: json["socket_id"],
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
        "socket_id": socketId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}


class DriverDetails {
  dynamic  id;
  dynamic  name;
  dynamic middleName;
  dynamic lastName;
  dynamic  email;
  dynamic  mobile;
  dynamic  stripeAccountId;
  dynamic dob;
  dynamic  gender;
  dynamic  isOnline;
  dynamic  countryCode;
  dynamic  otp;
  dynamic  token;
  dynamic  profile;
  dynamic bio;
  dynamic  roleId;
  dynamic  serviceProviderId;
  dynamic businessName;
  dynamic idProof;
  dynamic isVerify;
  dynamic  adminApproval;
  dynamic  status;
  dynamic  binbearStatus;
  dynamic binbearCurrentBooking;
  dynamic  isSendNotification;
  dynamic  emailVerifiedAt;
  dynamic  phoneVerifiedAt;
  dynamic  deviceToken;
  dynamic socketId;
  dynamic  createdAt;
  dynamic  updatedAt;

  DriverDetails({
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

  factory DriverDetails.fromJson(Map<String, dynamic> json) => DriverDetails(
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