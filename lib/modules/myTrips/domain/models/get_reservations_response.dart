import 'package:mr_omar/utils/base_cubit/base_pagination_response.dart';

import '../../../explore/domain/models/units_response.dart';

class GetReservationsResponse {
  bool? success;
  List<ReservationsData>? data;
  BasePaginationResponse? pagination;
  Filters? filters;

  GetReservationsResponse(
      {this.success, this.data, this.pagination, this.filters});

  GetReservationsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ReservationsData>[];
      json['data'].forEach((v) {
        data!.add(ReservationsData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? BasePaginationResponse.fromJson(json['pagination'])
        : null;
    filters =
    json['filters'] != null ? Filters.fromJson(json['filters']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (filters != null) {
      data['filters'] = filters!.toJson();
    }
    return data;
  }
}

class ReservationsData {
  int? id;
  String? reservationNumber;
  Unit? unit;
  CancellationPolicy? cancellationPolicy;
  String? checkInDate;
  String? checkOutDate;
  int? nights;
  GuestInformation? guestInformation;
  String? specialRequests;
  String? adminNotes;
  String? reservationNotes;
  DepositRequirements? depositRequirements;
  Pricing? pricing;
  TransferPayment? transferPayment;
  Status? status;
  Cancellation? cancellation;
  Timestamps? timestamps;

  ReservationsData(
      {this.id,
        this.reservationNumber,
        this.unit,
        this.cancellationPolicy,
        this.checkInDate,
        this.checkOutDate,
        this.nights,
        this.guestInformation,
        this.specialRequests,
        this.adminNotes,
        this.reservationNotes,
        this.depositRequirements,
        this.pricing,
        this.transferPayment,
        this.status,
        this.cancellation,
        this.timestamps});

  ReservationsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reservationNumber = json['reservation_number'];
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    cancellationPolicy = json['cancellation_policy'] != null
        ? CancellationPolicy.fromJson(json['cancellation_policy'])
        : null;
    checkInDate = json['check_in_date'];
    checkOutDate = json['check_out_date'];
    nights = json['nights'];
    guestInformation = json['guest_information'] != null
        ? GuestInformation.fromJson(json['guest_information'])
        : null;
    specialRequests = json['special_requests'];
    adminNotes = json['admin_notes'];
    reservationNotes = json['reservation_notes'];
    depositRequirements = json['deposit_requirements'] != null
        ? DepositRequirements.fromJson(json['deposit_requirements'])
        : null;
    pricing =
    json['pricing'] != null ? Pricing.fromJson(json['pricing']) : null;
    transferPayment = json['transfer_payment'] != null
        ? TransferPayment.fromJson(json['transfer_payment'])
        : null;
    status =
    json['status'] != null ? Status.fromJson(json['status']) : null;
    cancellation = json['cancellation'] != null
        ? Cancellation.fromJson(json['cancellation'])
        : null;
    timestamps = json['timestamps'] != null
        ? Timestamps.fromJson(json['timestamps'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reservation_number'] = reservationNumber;
    if (unit != null) {
      data['unit'] = unit!.toJson();
    }
    if (cancellationPolicy != null) {
      data['cancellation_policy'] = cancellationPolicy!.toJson();
    }
    data['check_in_date'] = checkInDate;
    data['check_out_date'] = checkOutDate;
    data['nights'] = nights;
    if (guestInformation != null) {
      data['guest_information'] = guestInformation!.toJson();
    }
    data['special_requests'] = specialRequests;
    data['admin_notes'] = adminNotes;
    data['reservation_notes'] = reservationNotes;
    if (depositRequirements != null) {
      data['deposit_requirements'] = depositRequirements!.toJson();
    }
    if (pricing != null) {
      data['pricing'] = pricing!.toJson();
    }
    if (transferPayment != null) {
      data['transfer_payment'] = transferPayment!.toJson();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (cancellation != null) {
      data['cancellation'] = cancellation!.toJson();
    }
    if (timestamps != null) {
      data['timestamps'] = timestamps!.toJson();
    }
    return data;
  }
}

class Unit {
  int? id;
  String? name;
  String? unitNumber;
  String? description;
  String? status;
  String? bedrooms;
  String? bathrooms;
  String? maxGuests;
  String? size;
  String? address;
  ReservationsUnitType? unitType;
  List<MonthlyPricing>? monthlyPricing;
  int? minimumReservationDays;
  PrimaryImage? primaryImage;
  String? createdAt;
  String? updatedAt;
  RatingStatistics? ratingStatistics;
  List<Images>? images;
  Unit(
      {this.id,
        this.name,
        this.unitNumber,
        this.description,
        this.status,
        this.bedrooms,
        this.bathrooms,
        this.maxGuests,
        this.size,
        this.address,
        this.unitType,
        this.monthlyPricing,
        this.minimumReservationDays,
        this.createdAt,
        this.updatedAt,
        this.ratingStatistics});

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    unitNumber = json['unit_number'];
    description = json['description'];
    status = json['status'];
    bedrooms = json['bedrooms'].toString();
    bathrooms = json['bathrooms'].toString();
    maxGuests = json['max_guests'].toString();
    size = json['size'];
    address = json['address'];
    unitType = json['unit_type'] != null
        ? ReservationsUnitType.fromJson(json['unit_type'])
        : null;
    if (json['monthly_pricing'] != null) {
      monthlyPricing = <MonthlyPricing>[];
      json['monthly_pricing'].forEach((v) {
        monthlyPricing!.add(MonthlyPricing.fromJson(v));
      });
    }
    minimumReservationDays = json['minimum_reservation_days'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ratingStatistics = json['rating_statistics'] != null
        ? RatingStatistics.fromJson(json['rating_statistics'])
        : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    primaryImage = json['primary_image'] != null
        ?   PrimaryImage.fromJson(json['primary_image'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['unit_number'] = unitNumber;
    data['description'] = description;
    data['status'] = status;
    data['bedrooms'] = bedrooms;
    data['bathrooms'] = bathrooms;
    data['max_guests'] = maxGuests;
    data['size'] = size;
    data['address'] = address;
    if (unitType != null) {
      data['unit_type'] = unitType!.toJson();
    }
    if (monthlyPricing != null) {
      data['monthly_pricing'] =
          monthlyPricing!.map((v) => v.toJson()).toList();
    }
    data['minimum_reservation_days'] = minimumReservationDays;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (ratingStatistics != null) {
      data['rating_statistics'] = ratingStatistics!.toJson();
    }
    return data;
  }
}
class PrimaryImage {
  int? id;
  String? imagePath;
  String? imageUrl;
  String? caption;
  int? order;
  bool? isPrimary;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  PrimaryImage(
      {this.id,
        this.imagePath,
        this.imageUrl,
        this.caption,
        this.order,
        this.isPrimary,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  PrimaryImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagePath = json['image_path'];
    imageUrl = json['image_url'];
    caption = json['caption'];
    order = json['order'];
    isPrimary = json['is_primary'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_path'] = imagePath;
    data['image_url'] = imageUrl;
    data['caption'] = caption;
    data['order'] = order;
    data['is_primary'] = isPrimary;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
class ReservationsUnitType {
  int? id;
  String? name;
  String? description;
  String? maxCapacity;

  bool? isActive;
  String? createdAt;
  String? updatedAt;

  ReservationsUnitType(
      {this.id,
        this.name,
        this.description,
        this.maxCapacity,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  ReservationsUnitType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    maxCapacity = json['max_capacity'].toString();
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['max_capacity'] = maxCapacity;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class MonthlyPricing {
  String? month;
  String? formattedMonth;
  String? dailyPrice;
  String? currency;
  bool? isActive;

  MonthlyPricing(
      {this.month,
        this.formattedMonth,
        this.dailyPrice,
        this.currency,
        this.isActive});

  MonthlyPricing.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    formattedMonth = json['formatted_month'];
    dailyPrice = json['daily_price'];
    currency = json['currency'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['formatted_month'] = formattedMonth;
    data['daily_price'] = dailyPrice;
    data['currency'] = currency;
    data['is_active'] = isActive;
    return data;
  }
}

class RatingStatistics {
  Averages? averages;
  String? totalReviews;

  RatingStatistics({this.averages, this.totalReviews});

  RatingStatistics.fromJson(Map<String, dynamic> json) {
    averages = json['averages'] != null
        ? Averages.fromJson(json['averages'])
        : null;
    totalReviews = json['total_reviews'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (averages != null) {
      data['averages'] = averages!.toJson();
    }
    data['total_reviews'] = totalReviews;
    return data;
  }
}

class Averages {
  String? overall;
  String? room;
  String? service;
  String? pricing;
  String? location;

  Averages(
      {this.overall, this.room, this.service, this.pricing, this.location});

  Averages.fromJson(Map<String, dynamic> json) {
    overall = json['overall'].toString();
    room = json['room'].toString();
    service = json['service'].toString();
    pricing = json['pricing'].toString();
    location = json['location'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['overall'] = overall;
    data['room'] = room;
    data['service'] = service;
    data['pricing'] = pricing;
    data['location'] = location;
    return data;
  }
}

class CancellationPolicy {
  String? id;
  String? name;
  String? description;
  String? cancellationWindow;
  String? refundPercentage;

  CancellationPolicy(
      {this.id,
        this.name,
        this.description,
        this.cancellationWindow,
        this.refundPercentage});

  CancellationPolicy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    cancellationWindow = json['cancellation_window'];
    refundPercentage = json['refund_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['cancellation_window'] = cancellationWindow;
    data['refund_percentage'] = refundPercentage;
    return data;
  }
}

class GuestInformation {
  String? name;
  String? phone;
  String? email;

  GuestInformation({this.name, this.phone, this.email});

  GuestInformation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}

class DepositRequirements {
  String? minimumDepositAmount;
  String? depositPercentage;
  String? calculatedDepositAmount;
  String? requiredDepositAmount;

  DepositRequirements(
      {this.minimumDepositAmount,
        this.depositPercentage,
        this.calculatedDepositAmount,
        this.requiredDepositAmount});

  DepositRequirements.fromJson(Map<String, dynamic> json) {
    minimumDepositAmount = json['minimum_deposit_amount'];
    depositPercentage = json['deposit_percentage'];
    calculatedDepositAmount = json['calculated_deposit_amount'].toString();
    requiredDepositAmount = json['required_deposit_amount'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['minimum_deposit_amount'] = minimumDepositAmount;
    data['deposit_percentage'] = depositPercentage;
    data['calculated_deposit_amount'] = calculatedDepositAmount;
    data['required_deposit_amount'] = requiredDepositAmount;
    return data;
  }
}

class Pricing {
  String? totalAmount;
  String? cleaningFee;
  String? securityDeposit;
  String? refundAmount;

  Pricing(
      {this.totalAmount,
        this.cleaningFee,
        this.securityDeposit,
        this.refundAmount});

  Pricing.fromJson(Map<String, dynamic> json) {
    totalAmount = json['total_amount'];
    cleaningFee = json['cleaning_fee'];
    securityDeposit = json['security_deposit'];
    refundAmount = json['refund_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_amount'] = totalAmount;
    data['cleaning_fee'] = cleaningFee;
    data['security_deposit'] = securityDeposit;
    data['refund_amount'] = refundAmount;
    return data;
  }
}

class TransferPayment {
  String? transferAmount;
  String? transferDate;
  String? transferImageUrl;
  String? minimumDepositAmount;
  String? depositPercentage;
  String? calculatedDepositAmount;
  String? requiredDepositAmount;
  bool? depositVerified;
  String? depositVerifiedAt;
  String? depositStatus;
  bool? isDepositSufficient;

  TransferPayment(
      {this.transferAmount,
        this.transferDate,
        this.transferImageUrl,
        this.minimumDepositAmount,
        this.depositPercentage,
        this.calculatedDepositAmount,
        this.requiredDepositAmount,
        this.depositVerified,
        this.depositVerifiedAt,
        this.depositStatus,
        this.isDepositSufficient});

  TransferPayment.fromJson(Map<String, dynamic> json) {
    transferAmount = json['transfer_amount'];
    transferDate = json['transfer_date'];
    transferImageUrl = json['transfer_image_url'];
    minimumDepositAmount = json['minimum_deposit_amount'];
    depositPercentage = json['deposit_percentage'];
    calculatedDepositAmount = json['calculated_deposit_amount'].toString();
    requiredDepositAmount = json['required_deposit_amount'].toString();
    depositVerified = json['deposit_verified'];
    depositVerifiedAt = json['deposit_verified_at'];
    depositStatus = json['deposit_status'];
    isDepositSufficient = json['is_deposit_sufficient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transfer_amount'] = transferAmount;
    data['transfer_date'] = transferDate;
    data['transfer_image_url'] = transferImageUrl;
    data['minimum_deposit_amount'] = minimumDepositAmount;
    data['deposit_percentage'] = depositPercentage;
    data['calculated_deposit_amount'] = calculatedDepositAmount;
    data['required_deposit_amount'] = requiredDepositAmount;
    data['deposit_verified'] = depositVerified;
    data['deposit_verified_at'] = depositVerifiedAt;
    data['deposit_status'] = depositStatus;
    data['is_deposit_sufficient'] = isDepositSufficient;
    return data;
  }
}

class Status {
  String? current;
  String? payment;
  bool? canCancel;
  String? badgeColor;
  String? paymentBadgeColor;

  Status(
      {this.current,
        this.payment,
        this.canCancel,
        this.badgeColor,
        this.paymentBadgeColor});

  Status.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    payment = json['payment'];
    canCancel = json['can_cancel'];
    badgeColor = json['badge_color'];
    paymentBadgeColor = json['payment_badge_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current'] = current;
    data['payment'] = payment;
    data['can_cancel'] = canCancel;
    data['badge_color'] = badgeColor;
    data['payment_badge_color'] = paymentBadgeColor;
    return data;
  }
}

class Cancellation {
  String? cancelledAt;
  String? cancellationReason;
  String? refundedAt;

  Cancellation({this.cancelledAt, this.cancellationReason, this.refundedAt});

  Cancellation.fromJson(Map<String, dynamic> json) {
    cancelledAt = json['cancelled_at'];
    cancellationReason = json['cancellation_reason'];
    refundedAt = json['refunded_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cancelled_at'] = cancelledAt;
    data['cancellation_reason'] = cancellationReason;
    data['refunded_at'] = refundedAt;
    return data;
  }
}

class Timestamps {
  String? confirmedAt;
  String? activatedAt;
  String? completedAt;
  String? createdAt;
  String? updatedAt;

  Timestamps(
      {this.confirmedAt,
        this.activatedAt,
        this.completedAt,
        this.createdAt,
        this.updatedAt});

  Timestamps.fromJson(Map<String, dynamic> json) {
    confirmedAt = json['confirmed_at'];
    activatedAt = json['activated_at'];
    completedAt = json['completed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['confirmed_at'] = confirmedAt;
    data['activated_at'] = activatedAt;
    data['completed_at'] = completedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}



class Filters {
  String? appliedFilter;
  String? appliedStatus;
  String? dateFrom;
  String? dateTo;
  String? search;
  String? sortBy;
  String? sortOrder;

  Filters(
      {this.appliedFilter,
        this.appliedStatus,
        this.dateFrom,
        this.dateTo,
        this.search,
        this.sortBy,
        this.sortOrder});

  Filters.fromJson(Map<String, dynamic> json) {
    appliedFilter = json['applied_filter'];
    appliedStatus = json['applied_status'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    search = json['search'];
    sortBy = json['sort_by'];
    sortOrder = json['sort_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['applied_filter'] = appliedFilter;
    data['applied_status'] = appliedStatus;
    data['date_from'] = dateFrom;
    data['date_to'] = dateTo;
    data['search'] = search;
    data['sort_by'] = sortBy;
    data['sort_order'] = sortOrder;
    return data;
  }
}
