class Message {
  int? id;
  String? text;
  bool? isUserMessage;
  String? createdAt;
  String? updatedAt;

  Message({
    this.id,
    this.text,
    this.isUserMessage,
    this.createdAt,
    this.updatedAt,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  Message copyWith({
    int? id,
    String? text,
    bool? isUserMessage,
    String? createdAt,
    String? updatedAt,
  }) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      isUserMessage: isUserMessage ?? this.isUserMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'isUserMessage': isUserMessage,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] != null ? map['id'] as int : null,
      text: map['text'] != null ? map['text'] as String : null,
      isUserMessage: map['isUserMessage'] != null
          ? map['isUserMessage'] as bool
          : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  @override
  String toString() {
    return 'Message(id: $id, text: $text, isUserMessage: $isUserMessage, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.text == text &&
        other.isUserMessage == isUserMessage &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        text.hashCode ^
        isUserMessage.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
