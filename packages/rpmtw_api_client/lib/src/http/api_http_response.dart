import "dart:typed_data";

class APIHttpResponse {
  final Map<String, dynamic> data;
  final int statusCode;
  final String message;
  final Uint8List bytes;

  const APIHttpResponse({
    required this.data,
    required this.statusCode,
    required this.message,
    required this.bytes,
  });
}
