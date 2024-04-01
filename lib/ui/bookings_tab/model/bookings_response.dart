// To parse this JSON data, do
//
//     final myBookingsResponse = myBookingsResponseFromJson(jsonString);

import 'dart:convert';

MyBookingsResponse myBookingsResponseFromJson(String str) =>
    MyBookingsResponse.fromJson(json.decode(str));

String myBookingsResponseToJson(MyBookingsResponse data) =>
    json.encode(data.toJson());

class MyBookingsResponse {
  bool? success;
  MyBookingData? data;
  String? message;

  MyBookingsResponse({
    this.success,
    this.data,
    this.message,
  });

  factory MyBookingsResponse.fromJson(Map<String, dynamic> json) =>
      MyBookingsResponse(
        success: json["success"],
        data:
            json["data"] == null ? null : MyBookingData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class MyBookingData {
  List<Booking>? bookings;

  MyBookingData({
    this.bookings,
  });

  factory MyBookingData.fromJson(Map<String, dynamic> json) => MyBookingData(
        bookings: json["bookings"] == null
            ? []
            : List<Booking>.from(
                json["bookings"]!.map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bookings": bookings == null
            ? []
            : List<dynamic>.from(bookings!.map((x) => x.toJson())),
      };
}

class Booking {
  dynamic id;
  dynamic providerId;
  dynamic bookingId;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
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
  dynamic serviceStatus;
  PickupAddress? pickupAddress;
  dynamic distance;
  dynamic time;

  Booking({
    this.id,
    this.providerId,
    this.bookingId,
    this.status,
    this.createdAt,
    this.updatedAt,
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
    this.serviceStatus,
    this.pickupAddress,
    this.distance,
    this.time,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        providerId: json["provider_id"],
        bookingId: json["booking_id"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        serviceStatus: json["service_status"],
        pickupAddress: json["pickup_address"] == null
            ? null
            : PickupAddress.fromJson(json["pickup_address"]),
        distance: json["distance"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "provider_id": providerId,
        "booking_id": bookingId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
        "service_status": serviceStatus,
        "pickup_address": pickupAddress?.toJson(),
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
