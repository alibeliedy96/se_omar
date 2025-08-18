import '../../../explore/domain/models/units_response.dart';

class UnitDetailsResponse {
  bool? success;
  UnitDetailsData? data;

  UnitDetailsResponse({this.success, this.data});

  UnitDetailsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? UnitDetailsData.fromJson(json['data']) : null;
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

class UnitDetailsData {
  int? id;
  String? name;
  String? unitNumber;
  String? description;
  String? status;
  int? bedrooms;
  int? bathrooms;
  int? maxGuests;
  String? size;
  String? address;
  UnitType? unitType;
  List<Images>? images;
  List<Amenities>? amenities;
  Pricing? pricing;
  String? createdAt;
  String? updatedAt;
  RatingStatistics? ratingStatistics;
  List<Reviews>? reviews;
  UnitDetailsData(
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
        this.images,
        this.amenities,
        this.pricing,
        this.createdAt,
        this.updatedAt});

  UnitDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    unitNumber = json['unit_number'];
    description = json['description'];
    status = json['status'];
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    maxGuests = json['max_guests'];
    size = json['size'].toString();
    address = json['address'];
    unitType = json['unit_type'] != null
        ? UnitType.fromJson(json['unit_type'])
        : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['amenities'] != null) {
      amenities = <Amenities>[];
      json['amenities'].forEach((v) {
        amenities!.add(Amenities.fromJson(v));
      });
    }
    pricing =
    json['pricing'] != null ? Pricing.fromJson(json['pricing']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ratingStatistics = json['rating_statistics'] != null
        ?   RatingStatistics.fromJson(json['rating_statistics'])
        : null;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(  Reviews.fromJson(v));
      });
    }
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
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (amenities != null) {
      data['amenities'] = amenities!.map((v) => v.toJson()).toList();
    }
    if (pricing != null) {
      data['pricing'] = pricing!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
class RatingStatistics {
  Averages? averages;
  int? totalReviews;

  RatingStatistics({this.averages, this.totalReviews});

  RatingStatistics.fromJson(Map<String, dynamic> json) {
    averages = json['averages'] != null
        ? Averages.fromJson(json['averages'])
        : null;
    totalReviews = json['total_reviews'];
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

class Reviews {
  int? id;
  User? user;
  int? overallRating;
  int? roomRating;
  int? serviceRating;
  int? pricingRating;
  int? locationRating;
  String? reviewText;
  String? reviewedAt;
  String? createdAt;

  Reviews(
      {this.id,
        this.user,
        this.overallRating,
        this.roomRating,
        this.serviceRating,
        this.pricingRating,
        this.locationRating,
        this.reviewText,
        this.reviewedAt,
        this.createdAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    overallRating = json['overall_rating'];
    roomRating = json['room_rating'];
    serviceRating = json['service_rating'];
    pricingRating = json['pricing_rating'];
    locationRating = json['location_rating'];
    reviewText = json['review_text'];
    reviewedAt = json['reviewed_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['overall_rating'] = overallRating;
    data['room_rating'] = roomRating;
    data['service_rating'] = serviceRating;
    data['pricing_rating'] = pricingRating;
    data['location_rating'] = locationRating;
    data['review_text'] = reviewText;
    data['reviewed_at'] = reviewedAt;
    data['created_at'] = createdAt;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? profileImage;

  User({this.id, this.name, this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['profile_image'] = profileImage;
    return data;
  }
}


