import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rpmtw_api_client/rpmtw_api_client.dart';

extension AvatarExtension on User {
  CircleAvatar avatar({double fontSize = 18}) {
    CircleAvatar _avatar;
    String? _avatarUrl = avatarUrl();

    if (_avatarUrl != null) {
      _avatar = CircleAvatar(
        backgroundImage: NetworkImage(_avatarUrl),
      );
    } else {
      /// 隨機生成顏色
      Color color =
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
      _avatar = CircleAvatar(
        backgroundColor: color,
        child: Text(
          username.characters.first,
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ),
      );
    }
    return _avatar;
  }
}
