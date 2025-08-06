class CheckCouponResponse {
  int? status;
  String? message;
  CheckCouponData? data;

  CheckCouponResponse({this.status, this.message, this.data});

  CheckCouponResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CheckCouponData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CheckCouponData {
  String? originalPrice;
  String? discountAmount;
  String? finalPrice;

  CheckCouponData({this.originalPrice, this.discountAmount, this.finalPrice});

  CheckCouponData.fromJson(Map<String, dynamic> json) {
    originalPrice = json['originalPrice'].toString();
    discountAmount = json['discountAmount'].toString();
    finalPrice = json['finalPrice'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['originalPrice'] = originalPrice;
    data['discountAmount'] = discountAmount;
    data['finalPrice'] = finalPrice;
    return data;
  }
}
