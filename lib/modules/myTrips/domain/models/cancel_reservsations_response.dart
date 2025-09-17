class CancelReservationsResponse {
  bool? success;
  String? message;


  CancelReservationsResponse({this.success, this.message, });

  CancelReservationsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

  }

}

