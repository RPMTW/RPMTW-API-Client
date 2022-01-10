abstract class BaseModel {
  final int statusCode;
  final String statusMessage;
  const BaseModel({
    required this.statusCode,
    required this.statusMessage,
  });

  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
