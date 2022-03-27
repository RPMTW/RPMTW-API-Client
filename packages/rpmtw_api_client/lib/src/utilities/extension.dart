import "dart:convert" as convert;

import "package:http/http.dart";

extension ResponseExtension on Response {
  Map<String, dynamic> get map => convert.json.decode(body);

  String get json => body;
}
