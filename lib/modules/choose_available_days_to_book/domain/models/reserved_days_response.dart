class ReservedDaysResponse {
  bool? success;
  List<String>? data;

  ReservedDaysResponse({this.success, this.data});

  ReservedDaysResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = this.data;
    return data;
  }
}
