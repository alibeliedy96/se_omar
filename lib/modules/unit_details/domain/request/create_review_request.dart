class CreateReviewRequestModel {
  final int unitId;
  final double overallRating;
  final double roomRating;
  final double serviceRating;
  final double pricingRating;
  final double locationRating;
  final String comment;

  CreateReviewRequestModel({
    required this.unitId,
    required this.overallRating,
    required this.roomRating,
    required this.serviceRating,
    required this.pricingRating,
    required this.locationRating,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      "unit_id": unitId,
      "overall_rating": overallRating,
      "room_rating": roomRating,
      "service_rating": serviceRating,
      "pricing_rating": pricingRating,
      "location_rating": locationRating,
      "comment": comment,
    };
  }
}
