class CreateReviewResponse {
  bool? success;
  String? message;


  CreateReviewResponse({this.success, this.message, });

  CreateReviewResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

  }

}

