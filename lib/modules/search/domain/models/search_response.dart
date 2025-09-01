class SettingsResponse {
  bool? success;
  Data? data;

  SettingsResponse({this.success, this.data});

  SettingsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? defaultReservationNotes;
  int? defaultDepositPercentage;
  int? defaultMinimumDepositAmount;
  bool? reservationAutoApprove;
  bool? requireDepositForApproval;
  int? minimumReservationDays;

  Data(
      {this.defaultReservationNotes,
        this.defaultDepositPercentage,
        this.defaultMinimumDepositAmount,
        this.reservationAutoApprove,
        this.requireDepositForApproval,
        this.minimumReservationDays});

  Data.fromJson(Map<String, dynamic> json) {
    defaultReservationNotes = json['default_reservation_notes'];
    defaultDepositPercentage = json['default_deposit_percentage'];
    defaultMinimumDepositAmount = json['default_minimum_deposit_amount'];
    reservationAutoApprove = json['reservation_auto_approve'];
    requireDepositForApproval = json['require_deposit_for_approval'];
    minimumReservationDays = json['minimum_reservation_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['default_reservation_notes'] = this.defaultReservationNotes;
    data['default_deposit_percentage'] = this.defaultDepositPercentage;
    data['default_minimum_deposit_amount'] = this.defaultMinimumDepositAmount;
    data['reservation_auto_approve'] = this.reservationAutoApprove;
    data['require_deposit_for_approval'] = this.requireDepositForApproval;
    data['minimum_reservation_days'] = this.minimumReservationDays;
    return data;
  }
}
