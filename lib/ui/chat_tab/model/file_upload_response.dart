class FileUploadResponse {
  dynamic success;
  Data? data;
  dynamic message;

  FileUploadResponse({this.success, this.data, this.message});

  FileUploadResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  dynamic image;
  dynamic type;

  Data({this.image, this.type});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['type'] = type;
    return data;
  }
}