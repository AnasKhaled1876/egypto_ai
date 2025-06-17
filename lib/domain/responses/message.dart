// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageResponse {
  final bool? status;
  final String? message;
  MessageResponse({this.status, this.message});

  MessageResponse copyWith({bool? status, String? message}) {
    return MessageResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'status': status, 'message': message};
  }

  factory MessageResponse.fromMap(Map<String, dynamic> map) {
    return MessageResponse(
      status: map['status'] != null ? map['status'] as bool : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageResponse.fromJson(String source) =>
      MessageResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MessageResponse(status: $status, message: $message)';

  @override
  bool operator ==(covariant MessageResponse other) {
    if (identical(this, other)) return true;

    return other.status == status && other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode;
}
