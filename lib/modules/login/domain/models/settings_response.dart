class SettingsResponse {
  bool? success;
  SettingsData? data;

  SettingsResponse({this.success, this.data});

  SettingsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? SettingsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SettingsData {
  String? defaultReservationNotes;
  int? defaultDepositPercentage;
  int? defaultMinimumDepositAmount;
  bool? reservationAutoApprove;
  bool? requireDepositForApproval;
  int? minimumReservationDays;

  SettingsData(
      {this.defaultReservationNotes,
        this.defaultDepositPercentage,
        this.defaultMinimumDepositAmount,
        this.reservationAutoApprove,
        this.requireDepositForApproval,
        this.minimumReservationDays});

  SettingsData.fromJson(Map<String, dynamic> json) {
    defaultReservationNotes = json['default_reservation_notes'];
    defaultDepositPercentage = json['default_deposit_percentage'];
    defaultMinimumDepositAmount = json['default_minimum_deposit_amount'];
    reservationAutoApprove = json['reservation_auto_approve'];
    requireDepositForApproval = json['require_deposit_for_approval'];
    minimumReservationDays = json['minimum_reservation_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['default_reservation_notes'] = defaultReservationNotes;
    data['default_deposit_percentage'] = defaultDepositPercentage;
    data['default_minimum_deposit_amount'] = defaultMinimumDepositAmount;
    data['reservation_auto_approve'] = reservationAutoApprove;
    data['require_deposit_for_approval'] = requireDepositForApproval;
    data['minimum_reservation_days'] = minimumReservationDays;
    return data;
  }
}
