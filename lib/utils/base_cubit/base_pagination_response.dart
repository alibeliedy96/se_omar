class BasePaginationResponse {
  late int currentPage;
  late int from;
  late int lastPage;
  late int perPage;
  late int to;
  late int total;

  BasePaginationResponse({this.currentPage = 0, this.from = 0, this.lastPage = 1, this.perPage = 0, this.to = 0, this.total = 0});

  int _parseIntOrZero(dynamic obj) => int.tryParse(obj.toString()) ?? 0;

  BasePaginationResponse.fromJson(Map<String, dynamic> json) {
    currentPage = _parseIntOrZero(json['current_page']);
    // from = _parseIntOrZero(json['from']);
    lastPage = _parseIntOrZero(json['total_pages']);
    perPage = _parseIntOrZero(json['per_page']);
    // to = _parseIntOrZero(json['to']);
    total = _parseIntOrZero(json['total']);
  }

  /**
   *   "total": 14,
      "count": 10,
      "per_page": 10,
      "current_page": 1,
      "total_pages": 2
   */
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

extension BasePaginationResponseEx on BasePaginationResponse {
  bool getIsLastPage() => currentPage >= lastPage;
}
