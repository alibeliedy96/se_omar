class BulkPricingResponse {
  bool? success;
  Data? data;

  BulkPricingResponse({this.success, this.data});

  BulkPricingResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  Summary? summary;
  List<DateRanges>? dateRanges;

  Data({this.summary, this.dateRanges});

  Data.fromJson(Map<String, dynamic> json) {
    summary =
    json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    if (json['date_ranges'] != null) {
      dateRanges = <DateRanges>[];
      json['date_ranges'].forEach((v) {
        dateRanges!.add(DateRanges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    if (dateRanges != null) {
      data['date_ranges'] = dateRanges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Summary {
  int? unitId;
  String? unitName;
  int? totalRanges;
  int? availableRanges;
  int? unavailableRanges;
  int? totalNights;
  int? totalCost;
  int? totalCleaningFees;
  int? totalSecurityDeposits;
  int? grandTotal;
  int? averageDailyRate;
  CancellationPolicy? cancellationPolicy;

  Summary(
      {this.unitId,
        this.unitName,
        this.totalRanges,
        this.availableRanges,
        this.unavailableRanges,
        this.totalNights,
        this.totalCost,
        this.totalCleaningFees,
        this.totalSecurityDeposits,
        this.grandTotal,
        this.averageDailyRate,
        this.cancellationPolicy});

  Summary.fromJson(Map<String, dynamic> json) {
    unitId = json['unit_id'];
    unitName = json['unit_name'];
    totalRanges = json['total_ranges'];
    availableRanges = json['available_ranges'];
    unavailableRanges = json['unavailable_ranges'];
    totalNights = json['total_nights'];
    totalCost = json['total_cost'];
    totalCleaningFees = json['total_cleaning_fees'];
    totalSecurityDeposits = json['total_security_deposits'];
    grandTotal = json['grand_total'];
    averageDailyRate = json['average_daily_rate'];
    cancellationPolicy = json['cancellation_policy'] != null
        ? CancellationPolicy.fromJson(json['cancellation_policy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unit_id'] = unitId;
    data['unit_name'] = unitName;
    data['total_ranges'] = totalRanges;
    data['available_ranges'] = availableRanges;
    data['unavailable_ranges'] = unavailableRanges;
    data['total_nights'] = totalNights;
    data['total_cost'] = totalCost;
    data['total_cleaning_fees'] = totalCleaningFees;
    data['total_security_deposits'] = totalSecurityDeposits;
    data['grand_total'] = grandTotal;
    data['average_daily_rate'] = averageDailyRate;
    if (cancellationPolicy != null) {
      data['cancellation_policy'] = cancellationPolicy!.toJson();
    }
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
    id = json['id'].toString();
    name = json['name'].toString();
    description = json['description'].toString();
    cancellationWindow = json['cancellation_window'].toString();
    refundPercentage = json['refund_percentage'].toString();
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

class DateRanges {
  int? rangeIndex;
  String? checkInDate;
  String? checkOutDate;
  int? nights;
  bool? isAvailable;
  PricingBreakdown? pricingBreakdown;
  int? totalCost;
  int? dailyAverage;

  DateRanges(
      {this.rangeIndex,
        this.checkInDate,
        this.checkOutDate,
        this.nights,
        this.isAvailable,
        this.pricingBreakdown,
        this.totalCost,
        this.dailyAverage});

  DateRanges.fromJson(Map<String, dynamic> json) {
    rangeIndex = json['range_index'];
    checkInDate = json['check_in_date'];
    checkOutDate = json['check_out_date'];
    nights = json['nights'];
    isAvailable = json['is_available'];
    pricingBreakdown = json['pricing_breakdown'] != null
        ? PricingBreakdown.fromJson(json['pricing_breakdown'])
        : null;
    totalCost = json['total_cost'];
    dailyAverage = json['daily_average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['range_index'] = rangeIndex;
    data['check_in_date'] = checkInDate;
    data['check_out_date'] = checkOutDate;
    data['nights'] = nights;
    data['is_available'] = isAvailable;
    if (pricingBreakdown != null) {
      data['pricing_breakdown'] = pricingBreakdown!.toJson();
    }
    data['total_cost'] = totalCost;
    data['daily_average'] = dailyAverage;
    return data;
  }
}

class PricingBreakdown {
  int? totalPrice;
  String? cleaningFee;
  String? securityDeposit;
  int? grandTotal;
  List<Breakdown>? breakdown;
  int? nights;
  bool? hasValidPricing;

  PricingBreakdown(
      {this.totalPrice,
        this.cleaningFee,
        this.securityDeposit,
        this.grandTotal,
        this.breakdown,
        this.nights,
        this.hasValidPricing});

  PricingBreakdown.fromJson(Map<String, dynamic> json) {
    totalPrice = json['total_price'];
    cleaningFee = json['cleaning_fee'];
    securityDeposit = json['security_deposit'];
    grandTotal = json['grand_total'];
    if (json['breakdown'] != null) {
      breakdown = <Breakdown>[];
      json['breakdown'].forEach((v) {
        breakdown!.add(Breakdown.fromJson(v));
      });
    }
    nights = json['nights'];
    hasValidPricing = json['has_valid_pricing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_price'] = totalPrice;
    data['cleaning_fee'] = cleaningFee;
    data['security_deposit'] = securityDeposit;
    data['grand_total'] = grandTotal;
    if (breakdown != null) {
      data['breakdown'] = breakdown!.map((v) => v.toJson()).toList();
    }
    data['nights'] = nights;
    data['has_valid_pricing'] = hasValidPricing;
    return data;
  }
}

class Breakdown {
  String? month;
  String? formattedMonth;
  String? dailyPrice;
  String? nights;
  String? subtotal;

  Breakdown(
      {this.month,
        this.formattedMonth,
        this.dailyPrice,
        this.nights,
        this.subtotal});

  Breakdown.fromJson(Map<String, dynamic> json) {
    month = json['month'].toString();
    formattedMonth = json['formatted_month'].toString();
    dailyPrice = json['daily_price'].toString();
    nights = json['nights'].toString();
    subtotal = json['subtotal'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['formatted_month'] = formattedMonth;
    data['daily_price'] = dailyPrice;
    data['nights'] = nights;
    data['subtotal'] = subtotal;
    return data;
  }
}
