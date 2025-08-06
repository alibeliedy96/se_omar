class ShowAdvisorAppointmentsResponse {
  int? status;
  String? message;
  List<ShowAdvisorAppointmentsData>? data;

  ShowAdvisorAppointmentsResponse({this.status, this.message, this.data});

  ShowAdvisorAppointmentsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ShowAdvisorAppointmentsData>[];
      json['data'].forEach((v) {
        data!.add(ShowAdvisorAppointmentsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShowAdvisorAppointmentsData {
  String? date;
  List<ShowAdvisorAppointments>? appointments;
  int? totalAppointments;

  ShowAdvisorAppointmentsData({this.date, this.appointments, this.totalAppointments});

  ShowAdvisorAppointmentsData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['appointments'] != null) {
      appointments = <ShowAdvisorAppointments>[];
      json['appointments'].forEach((v) {
        appointments!.add(ShowAdvisorAppointments.fromJson(v));
      });
    }
    totalAppointments = json['totalAppointments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (appointments != null) {
      data['appointments'] = appointments!.map((v) => v.toJson()).toList();
    }
    data['totalAppointments'] = totalAppointments;
    return data;
  }
}

class ShowAdvisorAppointments {
  int? id;
  String? startTimeLocal;

  int? durationMinutes;
  String? price;
  String? status;
  bool? isFree;
  AdviserInfo? adviser;

  ShowAdvisorAppointments(
      {this.id,
        this.startTimeLocal,

        this.durationMinutes,
        this.price,
        this.status,
        this.isFree,
        this.adviser});

  ShowAdvisorAppointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTimeLocal = json['startTimeLocal'];

    durationMinutes = json['durationMinutes'];
    price = json['price'];
    status = json['status'];
    isFree = json['isFree'];
    adviser =
    json['adviser'] != null ? AdviserInfo.fromJson(json['adviser']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['startTimeLocal'] = startTimeLocal;

    data['durationMinutes'] = durationMinutes;
    data['price'] = price;
    data['status'] = status;
    data['isFree'] = isFree;
    if (adviser != null) {
      data['adviser'] = adviser!.toJson();
    }
    return data;
  }
}

class AdviserInfo {
  int? id;
  String? fullName;
  String? fullNameAr;

  AdviserInfo({this.id, this.fullName, this.fullNameAr});

  AdviserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    fullNameAr = json['fullNameAr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['fullNameAr'] = fullNameAr;
    return data;
  }
}
