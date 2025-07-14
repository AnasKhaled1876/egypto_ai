// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DefaultResponse {
  final bool? status;
  final String? message;
  DefaultResponse({this.status, this.message});

  DefaultResponse copyWith({bool? status, String? message}) {
    return DefaultResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'status': status, 'message': message};
  }

  factory DefaultResponse.fromMap(Map<String, dynamic> map) {
    return DefaultResponse(
      status: map['status'] != null ? map['status'] as bool : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DefaultResponse.fromJson(String source) =>
      DefaultResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MessageResponse(status: $status, message: $message)';

  @override
  bool operator ==(covariant DefaultResponse other) {
    if (identical(this, other)) return true;

    return other.status == status && other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode;
}
