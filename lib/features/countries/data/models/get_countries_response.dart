import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../../shared/models/pagination.dart';
import '../../data/models/country_model.dart';

class CountriesResponse {
  final List<CountryModel> countries;
  final Pagination pagination;

  CountriesResponse({required this.countries, required this.pagination});

  CountriesResponse copyWith({
    List<CountryModel>? countries,
    Pagination? pagination,
  }) {
    return CountriesResponse(
      countries: countries ?? this.countries,
      pagination: pagination ?? this.pagination,
    );
  }

  factory CountriesResponse.fromMap(Map<String, dynamic> map) {
    return CountriesResponse(
      countries: List<CountryModel>.from(
        map['data']?.map((x) => CountryModel.fromMap(x)),
      ),
      pagination: Pagination.fromMap(map['pagination']),
    );
  }

  factory CountriesResponse.fromJson(String source) =>
      CountriesResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'CountriesResponse(countries: $countries, pagination: $pagination)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountriesResponse &&
        listEquals(other.countries, countries) &&
        other.pagination == pagination;
  }

  @override
  int get hashCode => countries.hashCode ^ pagination.hashCode;
}
