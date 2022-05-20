[![pub package](https://img.shields.io/pub/v/rpmtw_api_client.svg)](https://pub.dev/packages/rpmtw_api_client)
[![likes](https://badges.bar/rpmtw_api_client/likes)](https://pub.dev/packages/rpmtw_api_client/score)
[![popularity](https://badges.bar/rpmtw_api_client/popularity)](https://pub.dev/packages/rpmtw_api_client/score)
[![pub points](https://badges.bar/rpmtw_api_client/pub%20points)](https://pub.dev/packages/rpmtw_api_client/score)
# RPMTW API Client (Dart)
## Install
```bash
dart pub add rpmtw_api_client
```
### Example
```dart
import 'package:rpmtw_api_client/rpmtw_api_client.dart';

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

## Links
[Docs](https://pub.dev/documentation/rpmtw_api_client/latest/)

## Other Language
[Kotlin](https://github.com/RPMTW/RPMTW-API-Client-Kotlin)