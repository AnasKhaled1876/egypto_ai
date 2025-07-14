// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SendMessageResponse {
  final String message;
  final bool status;
  final String? data;

  SendMessageResponse({required this.message, required this.status, this.data});

  SendMessageResponse copyWith({String? message, bool? status, String? data}) {
    return SendMessageResponse(
      message: message ?? this.message,
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'status': status,
      'data': data,
    };
  }

  factory SendMessageResponse.fromMap(Map<String, dynamic> map) {
    return SendMessageResponse(
      message: map['message'] as String,
      status: map['status'] as bool,
      data: map['data'] != null ? map['data'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendMessageResponse.fromJson(String source) =>
      SendMessageResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SendMessageResponse(message: $message, status: $status, data: $data)';

  @override
  bool operator ==(covariant SendMessageResponse other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.status == status &&
        other.data == data;
  }

  @override
  int get hashCode => message.hashCode ^ status.hashCode ^ data.hashCode;
}
