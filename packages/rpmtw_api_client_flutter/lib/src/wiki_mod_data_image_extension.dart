import 'package:flutter/material.dart';
import 'package:rpmtw_api_client/src/models/rpmwiki/wiki_mod_data.dart';
import 'package:rpmtw_api_client_flutter/rpmtw_api_client_flutter.dart';

extension WikiModDataImageExtension on WikiModData {
  Image? imageWidget({double? width, double? height}) {
    if (imageStorageUUID == null) {
      return null;
    } else {
      String baseUrl = RPMTWApiClient.lastInstance.baseUrl;
      String url = '$baseUrl/storage/$imageStorageUUID/download';

      return Image.network(
        url,
        fit: BoxFit.cover,
        width: width,
        height: height,
      );
    }
  }
}
