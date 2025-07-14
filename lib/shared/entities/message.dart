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
}
