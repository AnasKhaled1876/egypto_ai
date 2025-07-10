// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:egypto/data/models/user.dart';

class LoginResponse {
  final String? token;
  final String? message;
  final EgyptoUser? user;
  final bool? status;
  LoginResponse({this.token, this.message, this.user, this.status});

  LoginResponse copyWith({
    String? token,
    String? message,
    EgyptoUser? user,
    bool? status,
  }) {
    return LoginResponse(
      token: token ?? this.token,
      message: message ?? this.message,
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'message': message,
      'user': user?.toMap(),
      'status': status,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      token: map['token'] != null ? map['token'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      user: map['user'] != null
          ? EgyptoUser.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      status: map['status'] != null ? map['status'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginResponse(token: $token, message: $message, user: $user, status: $status)';
  }

  @override
  bool operator ==(covariant LoginResponse other) {
    if (identical(this, other)) return true;

    return other.token == token &&
        other.message == message &&
        other.user == user &&
        other.status == status;
  }

  @override
  int get hashCode {
    return token.hashCode ^ message.hashCode ^ user.hashCode ^ status.hashCode;
  }
}
