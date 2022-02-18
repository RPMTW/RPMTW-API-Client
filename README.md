# RPMTW API Client For Dart

## Example
```dart
import 'package:rpmtw_api_client/rpmtw_api_client.dart';

void main() async {
  RPMTWApiClient.init(); // Initialize RPMTW API Client
  RPMTWApiClient apiClient = RPMTWApiClient.instance;
  print(apiClient.baseUrl);
  PasswordValidatedResult result =
      await apiClient.authResource.validPassword("12345"); // Valid password
  print(result.message);
}
```

## Other Language
[Kotlin](https://github.com/RPMTW/RPMTW-API-Client-Kotlin)