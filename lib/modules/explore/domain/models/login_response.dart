class LoginResponse {
  String? message;
  bool? isRegistered;
  int? status;

  LoginResponse({this.message, this.isRegistered, this.status});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isRegistered = json['is_registered'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['is_registered'] = isRegistered;
    data['status'] = status;
    return data;
  }
}
