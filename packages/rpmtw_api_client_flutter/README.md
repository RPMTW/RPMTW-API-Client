# RPMTW API Client (Flutter)

### Example
```dart
import 'package:rpmtw_api_client_flutter/rpmtw_api_client_flutter.dart';

void main() async {
  RPMTWApiClient.init(); // Initialize RPMTW API Client
  RPMTWApiClient apiClient = RPMTWApiClient.instance;
  print(apiClient.baseUrl);
  PasswordValidatedResult result =
      await apiClient.authResource.validPassword("12345"); // Valid password
  print(result.message);

  String message = await apiClient.otherResource.helloWorld();
  print(message);

  String ip = await apiClient.otherResource.getIP();
  print(ip);
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

## Other Language
[Kotlin](https://github.com/RPMTW/RPMTW-API-Client-Kotlin)