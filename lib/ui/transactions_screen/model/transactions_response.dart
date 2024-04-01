class TransactionResponse {
  bool? success;
  Data? data;
  String? message;

  TransactionResponse({this.success, this.data, this.message});

  TransactionResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
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
        bookingData!.add(new BookingData.fromJson(v));
      });
    }
    totalPayment = json['total_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookingData != null) {
      data['booking_data'] = this.bookingData!.map((v) => v.toJson()).toList();
    }
    data['total_payment'] = this.totalPayment;
    return data;
  }
}

class BookingData {
  int? id;
  String? bookingId;
  String? serviceProviderPayment;
  String? createdAt;
  String? paymentReceived;
  String? title;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['service_provider_payment'] = this.serviceProviderPayment;
    data['created_at'] = this.createdAt;
    data['payment_received'] = this.paymentReceived;
    data['title'] = this.title;
    return data;
  }
}
