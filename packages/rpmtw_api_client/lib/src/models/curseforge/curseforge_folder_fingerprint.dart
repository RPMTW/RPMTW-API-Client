import 'dart:convert';

import 'package:collection/collection.dart';

class CurseForgeFolderFingerprint {
  final String foldername;
  final List<int> fingerprints;
  const CurseForgeFolderFingerprint({
    required this.foldername,
    required this.fingerprints,
  });

  CurseForgeFolderFingerprint copyWith({
    String? foldername,
    List<int>? fingerprints,
  }) {
    return CurseForgeFolderFingerprint(
      foldername: foldername ?? this.foldername,
      fingerprints: fingerprints ?? this.fingerprints,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'foldername': foldername,
      'fingerprints': fingerprints,
    };
  }

  factory CurseForgeFolderFingerprint.fromMap(Map<String, dynamic> map) {
    return CurseForgeFolderFingerprint(
      foldername: map['foldername'] ?? '',
      fingerprints: List<int>.from(map['fingerprints']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeFolderFingerprint.fromJson(String source) =>
      CurseForgeFolderFingerprint.fromMap(json.decode(source));

  @override
  String toString() =>
      'CurseForgeFolderFingerprint(foldername: $foldername, fingerprints: $fingerprints)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is CurseForgeFolderFingerprint &&
        other.foldername == foldername &&
        listEquals(other.fingerprints, fingerprints);
  }

  @override
  int get hashCode => foldername.hashCode ^ fingerprints.hashCode;
}
