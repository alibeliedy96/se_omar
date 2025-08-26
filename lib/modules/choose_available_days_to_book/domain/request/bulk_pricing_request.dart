class BulkPricingRequest {
  final int unitId;
  final List<DateRange> dateRanges;

  BulkPricingRequest({
    required this.unitId,
    required this.dateRanges,
  });

  Map<String, dynamic> toJson() {
    return {
      "unit_id": unitId,
      "date_ranges": dateRanges.map((e) => e.toJson()).toList(),
    };
  }
}

class DateRange {
  final String checkInDate;
  final String checkOutDate;

  DateRange({
    required this.checkInDate,
    required this.checkOutDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "check_in_date": checkInDate,
      "check_out_date": checkOutDate,
    };
  }
}
