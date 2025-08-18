class SlidersResponse {
  bool? success;
  List<SliderData>? data;

  SlidersResponse({this.success, this.data});

  SlidersResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SliderData>[];
      json['data'].forEach((v) {
        data!.add(SliderData.fromJson(v));
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

class SliderData {
  int? id;
  String? title;
  String? image;
  int? order;

  SliderData({this.id, this.title, this.image, this.order});

  SliderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['order'] = order;
    return data;
  }
}
