class ForgotPasswordResponse {
  bool? success;
  String? message;


  ForgotPasswordResponse({this.success, this.message, });

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

  }


}


