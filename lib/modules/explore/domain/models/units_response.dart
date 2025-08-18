
class UnitsResponse {
  bool? success;
  List<UnitsData>? data;

  UnitsResponse({this.success, this.data});

  UnitsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <UnitsData>[];
      json['data'].forEach((v) {
        data!.add(UnitsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UnitsData {
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

  UnitsData(
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

  UnitsData.fromJson(Map<String, dynamic> json) {
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

class UnitType {
  int? id;
  String? name;
  String? description;
  int? maxCapacity;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  UnitType(
      {this.id,
        this.name,
        this.description,
        this.maxCapacity,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  UnitType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    maxCapacity = json['max_capacity'];
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

class Images {
  int? id;
  int? unitId;
  String? imagePath;
  String? caption;
  int? order;
  bool? isPrimary;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Images(
      {this.id,
        this.unitId,
        this.imagePath,
        this.caption,
        this.order,
        this.isPrimary,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitId = json['unit_id'];
    imagePath = json['image_path'];
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
    data['unit_id'] = unitId;
    data['image_path'] = imagePath;
    data['caption'] = caption;
    data['order'] = order;
    data['is_primary'] = isPrimary;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Amenities {
  int? id;
  String? name;
  String? icon;
  String? description;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Amenities(
      {this.id,
        this.name,
        this.icon,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  Amenities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    data['description'] = description;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? unitId;
  int? amenityId;

  Pivot({this.unitId, this.amenityId});

  Pivot.fromJson(Map<String, dynamic> json) {
    unitId = json['unit_id'];
    amenityId = json['amenity_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unit_id'] = unitId;
    data['amenity_id'] = amenityId;
    return data;
  }
}

class Pricing {
  int? id;
  int? unitId;
  String? basePrice;
  String? weekendPrice;
  String? holidayPrice;
  String? weeklyPrice;
  String? monthlyPrice;
  String? cleaningFee;
  String? securityDeposit;
  bool? isActive;
  String? validFrom;
  String? validTo;
  String? createdAt;
  String? updatedAt;

  Pricing(
      {this.id,
        this.unitId,
        this.basePrice,
        this.weekendPrice,
        this.holidayPrice,
        this.weeklyPrice,
        this.monthlyPrice,
        this.cleaningFee,
        this.securityDeposit,
        this.isActive,
        this.validFrom,
        this.validTo,
        this.createdAt,
        this.updatedAt});

  Pricing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitId = json['unit_id'];
    basePrice = json['base_price'].toString();
    weekendPrice = json['weekend_price'].toString();
    holidayPrice = json['holiday_price'].toString();
    weeklyPrice = json['weekly_price'].toString();
    monthlyPrice = json['monthly_price'].toString();
    cleaningFee = json['cleaning_fee'];
    securityDeposit = json['security_deposit'];
    isActive = json['is_active'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] =  id;
    data['unit_id'] = unitId;
    data['base_price'] = basePrice;
    data['weekend_price'] = weekendPrice;
    data['holiday_price'] = holidayPrice;
    data['weekly_price'] = weeklyPrice;
    data['monthly_price'] = monthlyPrice;
    data['cleaning_fee'] = cleaningFee;
    data['security_deposit'] = securityDeposit;
    data['is_active'] = isActive;
    data['valid_from'] = validFrom;
    data['valid_to'] = validTo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
