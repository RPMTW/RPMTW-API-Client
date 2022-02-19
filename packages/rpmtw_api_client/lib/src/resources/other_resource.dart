import 'dart:io';

import 'package:http/http.dart';
import 'package:rpmtw_api_client/src/resources/base_resource.dart';
import 'package:rpmtw_api_client/src/utilities/extension.dart';

class OtherResource extends BaseResource {
  OtherResource(
      {required Client httpClient,
      required String baseUrl,
      required String? token})
      : super(httpClient: httpClient, baseUrl: baseUrl, globalToken: token);

  Future<String> helloWorld() async {
    Response response = await httpClient.get(Uri.parse('$baseUrl/'));
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      return response.map['data']['message'];
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<String> getIP() async {
    Response response = await httpClient.get(Uri.parse('$baseUrl/ip'));
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      return response.map['data']['ip'];
    } else {
      throw Exception('Failed to get ip');
    }
  }
}
