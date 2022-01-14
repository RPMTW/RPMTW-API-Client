# RPMTW API Client (Dart)

### Example
```dart
import 'package:rpmtw_api_client/rpmtw_api_client.dart';

void main() async {
  RPMTWApiClient.init(development: true); // Initialize RPMTW API Client
  RPMTWApiClient apiClient = RPMTWApiClient.lastInstance;
  print(apiClient.baseUrl);
  PasswordValidatedResult result =
      await apiClient.authResource.validPassword("12345"); // Valid password
  print(result.message);
}
```