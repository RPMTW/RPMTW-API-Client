import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:rpmtw_api_client/rpmtw_api_client.dart';

void main() async {
  RPMTWApiClient apiClient = RPMTWApiClient(development: true);

  await apiClient.storageResource.downloadStorage(
      uuid: "12c7a662-a635-4b49-9578-96f831a8be0a", file: File("./test.txt"));
}
