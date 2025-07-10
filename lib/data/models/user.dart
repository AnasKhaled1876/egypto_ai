// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EgyptoUser {
  String? name;
  String? email;
  String? password;
  String? photoUrl;
  String? fcmToken;
  String? deviceInfo;
  
  EgyptoUser({
    this.name,
    this.email,
    this.password,
    this.photoUrl,
    this.fcmToken,
    this.deviceInfo = 'mobile',
  });

  EgyptoUser copyWith({
    String? name,
    String? email,
    String? password,
    String? photoUrl,
    String? fcmToken,
    String? deviceInfo,
  }) {
    return EgyptoUser(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      photoUrl: photoUrl ?? this.photoUrl,
      fcmToken: fcmToken ?? this.fcmToken,
      deviceInfo: deviceInfo ?? this.deviceInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'photoUrl': photoUrl,
      'fcmToken': fcmToken,
      'deviceInfo': deviceInfo,
    };
  }

  factory EgyptoUser.fromMap(Map<String, dynamic> map) {
    return EgyptoUser(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      fcmToken: map['fcmToken'] != null ? map['fcmToken'] as String : null,
      deviceInfo: map['deviceInfo'] as String? ?? 'mobile',
    );
  }

  String toJson() => json.encode(toMap());

  factory EgyptoUser.fromJson(String source) =>
      EgyptoUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'EgyptoUser(name: $name, email: $email, photoUrl: $photoUrl, fcmToken: $fcmToken, deviceInfo: $deviceInfo)';

  @override
  bool operator ==(covariant EgyptoUser other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password &&
        other.photoUrl == photoUrl &&
        other.fcmToken == fcmToken &&
        other.deviceInfo == deviceInfo;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      photoUrl.hashCode ^
      fcmToken.hashCode ^
      deviceInfo.hashCode;
}
