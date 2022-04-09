import 'dart:convert';

class CurseForgeSortOrder {
  final String data;
  
  const CurseForgeSortOrder({
    required this.data,
  });

  CurseForgeSortOrder copyWith({
    String? data,
  }) {
    return CurseForgeSortOrder(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data,
    };
  }

  factory CurseForgeSortOrder.fromMap(Map<String, dynamic> map) {
    return CurseForgeSortOrder(
      data: map['data'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeSortOrder.fromJson(String source) =>
      CurseForgeSortOrder.fromMap(json.decode(source));

  @override
  String toString() => 'SortOrder(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurseForgeSortOrder && other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}
