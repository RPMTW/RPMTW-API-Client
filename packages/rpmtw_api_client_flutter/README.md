[![pub package](https://img.shields.io/pub/v/rpmtw_api_client_flutter.svg)](https://pub.dev/packages/rpmtw_api_client_flutter)
[![likes](https://badges.bar/rpmtw_api_client_flutter/likes)](https://pub.dev/packages/rpmtw_api_client_flutter/score)
[![popularity](https://badges.bar/rpmtw_api_client_flutter/popularity)](https://pub.dev/packages/rpmtw_api_client_flutter/score)
[![pub points](https://badges.bar/rpmtw_api_client_flutter/pub%20points)](https://pub.dev/packages/rpmtw_api_client_flutter/score)
# RPMTW API Client (Flutter)
## Install
```bash
flutter pub add rpmtw_api_client_flutter
```
### Example
```dart
import 'package:rpmtw_api_client_flutter/rpmtw_api_client_flutter.dart';

void main() async {
  RPMTWApiClient.init(); // Initialize RPMTW API Client
  RPMTWApiClient apiClient = RPMTWApiClient.instance;
  print(apiClient.apiBaseUrl);

  // Valid password
  PasswordValidatedResult result =
      await apiClient.authResource.validPassword('12345');
  print(result.message);

  // Print hello world
  String message = await apiClient.otherResource.helloWorld();
  print(message);

  // Get client's IP address
  String ip = await apiClient.otherResource.getIP();
  print(ip);

  // Search for mods
  ListModelResponse modsResponse =
      await apiClient.minecraftResource.search(limit: 5);
  print(modsResponse.data);
  print(modsResponse.limit);
  print(modsResponse.skip);
  print(modsResponse.total);
}
```

## Widgets

### User Avatar

```dart
import 'package:rpmtw_api_client_flutter/rpmtw_api_client_flutter.dart';

User user = User(...);
user.avatar(fontSize: 20) // fontSize defaults to 18
```

### Minecraft Mod Image

```dart
import 'package:rpmtw_api_client_flutter/rpmtw_api_client_flutter.dart';

MinecraftMod mod = MinecraftMod(...);
mod.imageWidget(width: 50, height: 50)
```

## Links
[Docs](https://pub.dev/documentation/rpmtw_api_client_flutter/latest/)

## Other Language
[Kotlin](https://github.com/RPMTW/RPMTW-API-Client-Kotlin)