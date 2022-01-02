import 'dart:convert' as convert;

import 'package:dio/dio.dart';

extension ResponseExtension on Response {
  Map<String, dynamic> get map {
    if (data is Map) {
      return data;
    } else {
      return convert.json.decode(data.toString());
    }
  }

  String get json {
    if (data is Map) {
      return convert.json.encode(data);
    } else {
      return data.toString();
    }
  }
}
