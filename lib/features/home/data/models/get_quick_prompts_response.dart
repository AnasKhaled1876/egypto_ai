import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:egypto/features/home/data/models/quick_prompt.dart';

class GetQuickPromptsResponse {
  final List<QuickPrompt> data;
  final bool status;
  GetQuickPromptsResponse({required this.data, required this.status});

  GetQuickPromptsResponse copyWith({List<QuickPrompt>? data, bool? status}) {
    return GetQuickPromptsResponse(
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {'data': data.map((x) => x.toMap()).toList(), 'status': status};
  }

  factory GetQuickPromptsResponse.fromMap(Map<String, dynamic> map) {
    return GetQuickPromptsResponse(
      data: List<QuickPrompt>.from(
        map['data']?.map((x) => QuickPrompt.fromMap(x)),
      ),
      status: map['status'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetQuickPromptsResponse.fromJson(String source) =>
      GetQuickPromptsResponse.fromMap(json.decode(source));

  @override
  String toString() => 'GetQuickPromptsResponse(data: $data, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetQuickPromptsResponse &&
        listEquals(other.data, data) &&
        other.status == status;
  }

  @override
  int get hashCode => data.hashCode ^ status.hashCode;
}
