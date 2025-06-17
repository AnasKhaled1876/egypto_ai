import 'dart:convert';

import 'data.dart';

class CheckEmailResponse {
  bool? status;
  Data? data;

  CheckEmailResponse({this.status, this.data});

  factory CheckEmailResponse.fromMap(Map<String, dynamic> data) {
    return CheckEmailResponse(
      status: data['status'] as bool?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {'status': status, 'data': data?.toMap()};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CheckEmailResponse].
  factory CheckEmailResponse.fromJson(String data) {
    return CheckEmailResponse.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [CheckEmailResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
