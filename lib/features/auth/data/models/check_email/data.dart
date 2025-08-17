import 'dart:convert';

class Data {
  bool? exists;
  String? email;

  Data({this.exists, this.email});

  factory Data.fromMap(Map<String, dynamic> data) =>
      Data(exists: data['exists'] as bool?, email: data['email'] as String?);

  Map<String, dynamic> toMap() => {'exists': exists, 'email': email};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());
}
