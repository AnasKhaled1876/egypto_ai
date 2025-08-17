enum Policy {
  termsOfUse,
  privacyPolicy,
}


extension PolicyExtension on Policy {
  String get title {
    switch (this) {
      case Policy.termsOfUse:
        return 'Terms of Use';
      case Policy.privacyPolicy:
        return 'Privacy Policy';
    }
  }

  /// Converts the Policy enum to a map with 'name' and 'title' keys
  Map<String, dynamic> toMap() {
    return {
      'name': toString().split('.').last,
      'title': title,
    };
  }

  /// Converts a map with a 'name' key to a Policy enum
  static Policy? fromMap(Map<String, dynamic> map) {
    final name = map['name'] as String?;
    if (name == null) return null;
    
    return Policy.values.firstWhere(
      (policy) => policy.toString() == 'Policy.$name',
      orElse: () => throw ArgumentError('No Policy found with name: $name'),
    );
  }

  /// Converts a string to a Policy enum
  static Policy? fromString(String? value) {
    if (value == null) return null;
    
    return Policy.values.firstWhere(
      (policy) => policy.toString() == 'Policy.$value',
      orElse: () => throw ArgumentError('No Policy found with name: $value'),
    );
  }
}