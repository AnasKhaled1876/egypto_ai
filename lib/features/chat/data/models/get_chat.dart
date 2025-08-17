// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class GetChatResponse {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String lastMessage;
  final DateTime lastMessageTime;
  final List<String> messages;
  GetChatResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.messages,
  });

  GetChatResponse copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? lastMessage,
    DateTime? lastMessageTime,
    List<String>? messages,
  }) {
    return GetChatResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.millisecondsSinceEpoch,
      'messages': messages,
    };
  }

  factory GetChatResponse.fromMap(Map<String, dynamic> map) {
    return GetChatResponse(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      lastMessage: map['lastMessage'] as String,
      lastMessageTime: DateTime.fromMillisecondsSinceEpoch(
        map['lastMessageTime'] as int,
      ),
      messages: List<String>.from((map['messages'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetChatResponse.fromJson(String source) =>
      GetChatResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetChatResponse(id: $id, name: $name, description: $description, imageUrl: $imageUrl, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, messages: $messages)';
  }

  @override
  bool operator ==(covariant GetChatResponse other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.lastMessage == lastMessage &&
        other.lastMessageTime == lastMessageTime &&
        listEquals(other.messages, messages);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        imageUrl.hashCode ^
        lastMessage.hashCode ^
        lastMessageTime.hashCode ^
        messages.hashCode;
  }
}
