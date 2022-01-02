import 'package:rpmtw_api_client/src/api_client.dart';

abstract class BaseModel {
  final int status;
  final String message;
  const BaseModel({
    required this.status,
    required this.message,
  });
}
