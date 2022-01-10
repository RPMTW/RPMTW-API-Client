import 'dart:convert';

import 'package:rpmtw_api_client/src/models/base_model.dart';

class PasswordValidatedResult extends BaseModel {
  final bool isValid;
  final int code;
  final String resultMessage;

  PasswordValidatedResult({
    required this.isValid,
    required this.code,
    required this.resultMessage,
    required int status,
    required String statusMessage,
  }) : super(statusCode: status, statusMessage: statusMessage);

  PasswordValidatedResult copyWith({
    bool? isValid,
    int? code,
    String? resultMessage,
    int? statusCode,
    String? statusMessage,
  }) {
    return PasswordValidatedResult(
      isValid: isValid ?? this.isValid,
      code: code ?? this.code,
      resultMessage: resultMessage ?? this.resultMessage,
      status: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'isValid': isValid,
      'code': code,
      'message': resultMessage,
    };
  }

  factory PasswordValidatedResult.fromMap(Map<String, dynamic> map) {
    Map data = map['data'];
    return PasswordValidatedResult(
      isValid: data['isValid'] ?? false,
      code: data['code']?.toInt() ?? 0,
      resultMessage: data['message'] ?? '',
      status: map['status']?.toInt() ?? 0,
      statusMessage: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PasswordValidatedResult.fromJson(String source) =>
      PasswordValidatedResult.fromMap(json.decode(source));

  @override
  String toString() =>
      'PasswordValidatedResult(isValid: $isValid, code: $code, message: $resultMessage, status: $statusCode, message: $statusMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PasswordValidatedResult &&
        other.isValid == isValid &&
        other.code == code &&
        other.resultMessage == resultMessage &&
        other.statusCode == statusCode &&
        other.statusMessage == statusMessage;
  }

  @override
  int get hashCode =>
      isValid.hashCode ^
      code.hashCode ^
      resultMessage.hashCode ^
      statusCode.hashCode ^
      statusMessage.hashCode;
}
