import 'package:mr_omar/utils/base_cubit/base_pagination_response.dart';

import '../../../explore/domain/models/units_response.dart';

class SearchResponse {
  bool? success;
  List<SearchData>? data;
  BasePaginationResponse? pagination;
  Filters? filters;

  SearchResponse({this.success, this.data, this.pagination, this.filters});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SearchData>[];
      json['data'].forEach((v) {
        data!.add(SearchData.fromJson(v));
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

class SearchData {
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
  UnitType? unitType;
  List<Images>? images;
  List<Amenities>? amenities;
  List<MonthlyPricing>? monthlyPricing;
  String? minimumReservationDays;
  String? createdAt;
  String? updatedAt;
  RatingStatistics? ratingStatistics;

  SearchData(
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
        this.monthlyPricing,
        this.minimumReservationDays,
        this.createdAt,
        this.updatedAt,
        this.ratingStatistics});

  SearchData.fromJson(Map<String, dynamic> json) {
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
    if (json['monthly_pricing'] != null) {
      monthlyPricing = <MonthlyPricing>[];
      json['monthly_pricing'].forEach((v) {
        monthlyPricing!.add(MonthlyPricing.fromJson(v));
      });
    }
    minimumReservationDays = json['minimum_reservation_days'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ratingStatistics = json['rating_statistics'] != null
        ? RatingStatistics.fromJson(json['rating_statistics'])
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
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (amenities != null) {
      data['amenities'] = amenities!.map((v) => v.toJson()).toList();
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



class Filters {
  String? searchTerm;
  String? unitTypeId;
  String? amenities;
  String? minPrice;
  String? maxPrice;
  String? minGuests;
  String? maxGuests;
  String? checkIn;
  String? checkOut;
  String? sortBy;
  String? sortOrder;

  Filters(
      {this.searchTerm,
        this.unitTypeId,
        this.amenities,
        this.minPrice,
        this.maxPrice,
        this.minGuests,
        this.maxGuests,
        this.checkIn,
        this.checkOut,
        this.sortBy,
        this.sortOrder});

  Filters.fromJson(Map<String, dynamic> json) {
    searchTerm = json['search_term'].toString();
    unitTypeId = json['unit_type_id'].toString();
    amenities = json['amenities'].toString();
    minPrice = json['min_price'].toString();
    maxPrice = json['max_price'].toString();
    minGuests = json['min_guests'].toString();
    maxGuests = json['max_guests'].toString();
    checkIn = json['check_in'].toString();
    checkOut = json['check_out'].toString();
    sortBy = json['sort_by'].toString();
    sortOrder = json['sort_order'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search_term'] = searchTerm;
    data['unit_type_id'] = unitTypeId;
    data['amenities'] = amenities;
    data['min_price'] = minPrice;
    data['max_price'] = maxPrice;
    data['min_guests'] = minGuests;
    data['max_guests'] = maxGuests;
    data['check_in'] = checkIn;
    data['check_out'] = checkOut;
    data['sort_by'] = sortBy;
    data['sort_order'] = sortOrder;
    return data;
  }
}
