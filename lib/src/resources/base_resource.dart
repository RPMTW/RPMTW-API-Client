import 'package:dio/dio.dart';

abstract class BaseResource {
  Dio httpClient;

  BaseResource({required this.httpClient});
}
