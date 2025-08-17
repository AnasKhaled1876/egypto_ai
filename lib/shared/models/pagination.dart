import 'dart:convert';

class Pagination {
  final int page;
  final int limit;
  final int total;
  final int totalPages;
  Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  Pagination copyWith({
    int? page,
    int? limit,
    int? total,
    int? totalPages,
  }) {
    return Pagination(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      total: total ?? this.total,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'totalPages': totalPages,
    };
  }

  factory Pagination.fromMap(Map<String, dynamic> map) {
    return Pagination(
      page: map['page']?.toInt() ?? 0,
      limit: map['limit']?.toInt() ?? 0,
      total: map['total']?.toInt() ?? 0,
      totalPages: map['totalPages']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pagination.fromJson(String source) => Pagination.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Pagination(page: $page, limit: $limit, total: $total, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Pagination &&
      other.page == page &&
      other.limit == limit &&
      other.total == total &&
      other.totalPages == totalPages;
  }

  @override
  int get hashCode {
    return page.hashCode ^
      limit.hashCode ^
      total.hashCode ^
      totalPages.hashCode;
  }
}
