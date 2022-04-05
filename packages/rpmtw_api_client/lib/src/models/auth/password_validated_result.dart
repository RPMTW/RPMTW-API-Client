import "dart:convert";

class PasswordValidatedResult {
  final bool isValid;
  final int code;
  final String message;

  PasswordValidatedResult({
    required this.isValid,
    required this.code,
    required this.message,
  });

  PasswordValidatedResult copyWith({
    bool? isValid,
    int? code,
    String? message,
  }) {
    return PasswordValidatedResult(
      isValid: isValid ?? this.isValid,
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "isValid": isValid,
      "code": code,
      "message": message,
    };
  }

  factory PasswordValidatedResult.fromMap(Map<String, dynamic> map) {
    return PasswordValidatedResult(
      isValid: map["isValid"] ?? false,
      code: map["code"],
      message: map["message"],
    );
  }

  String toJson() => json.encode(toMap());

  factory PasswordValidatedResult.fromJson(String source) =>
      PasswordValidatedResult.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PasswordValidatedResult &&
        other.isValid == isValid &&
        other.code == code &&
        other.message == message;
  }

  @override
  int get hashCode => isValid.hashCode ^ code.hashCode ^ message.hashCode;

  @override
  String toString() =>
      "PasswordValidatedResult(isValid: $isValid, code: $code, resultMessage: $message)";
}
