// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SendMessageResponse {
  final String messageId;
  final String status;
  final DateTime timestamp;
  SendMessageResponse({
    required this.messageId,
    required this.status,
    required this.timestamp,
  });

  

  SendMessageResponse copyWith({
    String? messageId,
    String? status,
    DateTime? timestamp,
  }) {
    return SendMessageResponse(
      messageId: messageId ?? this.messageId,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'status': status,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory SendMessageResponse.fromMap(Map<String, dynamic> map) {
    return SendMessageResponse(
      messageId: map['messageId'] as String,
      status: map['status'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory SendMessageResponse.fromJson(String source) => SendMessageResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SendMessageResponse(messageId: $messageId, status: $status, timestamp: $timestamp)';

  @override
  bool operator ==(covariant SendMessageResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.messageId == messageId &&
      other.status == status &&
      other.timestamp == timestamp;
  }

  @override
  int get hashCode => messageId.hashCode ^ status.hashCode ^ timestamp.hashCode;
}
