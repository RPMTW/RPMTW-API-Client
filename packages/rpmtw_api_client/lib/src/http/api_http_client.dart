import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:rpmtw_api_client/src/api_client.dart';
import 'package:rpmtw_api_client/src/http/api_http_response.dart';
import 'package:rpmtw_api_client/src/utilities/exceptions.dart';

class APIHttpClient {
  final String baseUrl;
  final Client _client;

  String? get globalToken => RPMTWApiClient.instance.apiGlobalToken;

  APIHttpClient(this.baseUrl, {Client? client}) : _client = client ?? Client();

  Future<APIHttpResponse> _send<T>(
      {required String method,
      required String path,
      Map<String, dynamic>? query,
      Object? body,
      String? token,
      Map<String, String>? headers}) async {
    final String? _token = token ?? globalToken;
    final Uri uri =
        Uri.parse(baseUrl + (path.startsWith('/') ? path : '/$path')).replace(
            query: query?.entries
                .where((e) => e.value != null)
                .map((e) => '${e.key}=${e.value}')
                .join('&'));

    final Response response;
    final Map<String, String> _headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (_token != null) 'Authorization': 'Bearer $_token',
      'User-Agent': 'RPMTW_API_Client/${RPMTWApiClient.version} (Dart)',
    }..addAll(headers ?? {});

    late final Object? _body;
    if (body is Map || body is List) {
      _body = json.encode(body);
    } else {
      _body = body;
    }

    if (method == 'GET') {
      response = await _client.get(uri, headers: _headers);
    } else if (method == 'POST') {
      response = await _client.post(uri, headers: _headers, body: _body);
    } else if (method == 'PATCH') {
      response = await _client.patch(uri, headers: _headers, body: _body);
    } else if (method == 'DELETE') {
      response = await _client.delete(uri, headers: _headers, body: _body);
    } else {
      throw Exception('Invalid method: $method');
    }

    late final Map<String, dynamic> data;
    late String message;
    final int statusCode = response.statusCode;

    late final Map<String, dynamic>? _data;
    try {
      _data = json.decode(response.body);
    } catch (e) {
      _data = null;
    }
    message = _data?['message'] ?? 'Failed to get data';

    if (statusCode == HttpStatus.ok) {
      data = _data?['data']?.cast<String, dynamic>();
    } else if (statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    } else if (statusCode == HttpStatus.badRequest ||
        statusCode == HttpStatus.forbidden) {
      throw Exception(message);
    } else if (statusCode == HttpStatus.notFound) {
      throw ModelNotFoundException<T>();
    } else if (statusCode == HttpStatus.internalServerError) {
      throw Exception('Internal server error');
    } else {
      throw Exception('Unknown error: $message ($statusCode)');
    }

    return APIHttpResponse(
        data: data,
        statusCode: statusCode,
        message: message,
        bytes: response.bodyBytes);
  }

  Future<APIHttpResponse> get<T>(String path,
          {Map<String, dynamic>? query,
          String? token,
          Map<String, String>? headers}) =>
      _send<T>(
          method: 'GET',
          path: path,
          query: query,
          token: token,
          headers: headers);

  Future<APIHttpResponse> post<T>(String path,
          {Map<String, dynamic>? query,
          Object? body,
          String? token,
          Map<String, String>? headers}) =>
      _send<T>(
          method: 'POST',
          path: path,
          query: query,
          body: body,
          token: token,
          headers: headers);

  Future<APIHttpResponse> patch<T>(String path,
          {Map<String, dynamic>? query,
          Object? body,
          String? token,
          Map<String, String>? headers}) =>
      _send<T>(
          method: 'PATCH',
          path: path,
          query: query,
          body: body,
          token: token,
          headers: headers);

  Future<APIHttpResponse> delete<T>(String path,
          {Map<String, dynamic>? query,
          Object? body,
          String? token,
          Map<String, String>? headers}) =>
      _send<T>(
          method: 'DELETE',
          path: path,
          query: query,
          body: body,
          token: token,
          headers: headers);
}
