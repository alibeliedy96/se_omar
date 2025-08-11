class RegisterUserResponse {
  int? status;
  String? message;


  RegisterUserResponse({this.status, this.message, });

  RegisterUserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

  }


}


