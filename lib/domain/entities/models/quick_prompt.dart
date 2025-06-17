import 'dart:convert';

class QuickPrompt {
  final int id;
  final String text;
  final String emoji;
  QuickPrompt({required this.id, required this.text, required this.emoji});

  QuickPrompt copyWith({int? id, String? text, String? emoji}) {
    return QuickPrompt(
      id: id ?? this.id,
      text: text ?? this.text,
      emoji: emoji ?? this.emoji,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'text': text, 'emoji': emoji};
  }

  factory QuickPrompt.fromMap(Map<String, dynamic> map) {
    return QuickPrompt(
      id: map['id']?.toInt() ?? 0,
      text: map['text'] ?? '',
      emoji: map['emoji'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory QuickPrompt.fromJson(String source) =>
      QuickPrompt.fromMap(json.decode(source));

  @override
  String toString() => 'QuickPrompt(id: $id, text: $text, emoji: $emoji)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuickPrompt &&
        other.id == id &&
        other.text == text &&
        other.emoji == emoji;
  }

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ emoji.hashCode;
}
