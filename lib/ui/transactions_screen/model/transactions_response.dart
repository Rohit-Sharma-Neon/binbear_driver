class TransactionResponse {
  bool? success;
  Data? data;
  String? message;

  TransactionResponse({this.success, this.data, this.message});

  TransactionResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  List<BookingData>? bookingData;
  int? totalPayment;

  Data({this.bookingData, this.totalPayment});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['booking_data'] != null) {
      bookingData = <BookingData>[];
      json['booking_data'].forEach((v) {
        bookingData!.add(BookingData.fromJson(v));
      });
    }
    totalPayment = json['total_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (bookingData != null) {
      data['booking_data'] = bookingData!.map((v) => v.toJson()).toList();
    }
    data['total_payment'] = totalPayment;
    return data;
  }
}

class BookingData {
  dynamic id;
  dynamic bookingId;
  dynamic serviceProviderPayment;
  dynamic createdAt;
  dynamic paymentReceived;
  dynamic title;

  BookingData(
      {this.id,
        this.bookingId,
        this.serviceProviderPayment,
        this.createdAt,
        this.paymentReceived,
        this.title});

  BookingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceProviderPayment = json['service_provider_payment'];
    createdAt = json['created_at'];
    paymentReceived = json['payment_received'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['service_provider_payment'] = serviceProviderPayment;
    data['created_at'] = createdAt;
    data['payment_received'] = paymentReceived;
    data['title'] = title;
    return data;
  }
}
