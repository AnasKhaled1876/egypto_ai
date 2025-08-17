class CountryModel {
  final String id;
  final String code;
  final String name;
  final String flagUrl;
  final String language;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CountryModel({
    required this.id,
    required this.code,
    required this.name,
    required this.flagUrl,
    required this.language,
    this.createdAt,
    this.updatedAt,
  });

  factory CountryModel.fromMap(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      flagUrl: json['flagUrl'] as String,
      language: json['language'] as String,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'flagUrl': flagUrl,
      'language': language,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
