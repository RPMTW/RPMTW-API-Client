import 'package:flutter/material.dart';
import 'package:rpmtw_api_client_flutter/rpmtw_api_client_flutter.dart';

extension WikiModDataImageExtension on MinecraftMod {
  Image? imageWidget({double? width, double? height}) {
    if (imageStorageUUID == null) {
      return null;
    } else {
      String url = imageUrl!;

      return Image.network(
        url,
        fit: BoxFit.cover,
        width: width,
        height: height,
      );
    }
  }
}
