# RPMTW API Client (Flutter)

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

## Widgets

### User Avatar

```dart
import 'package:rpmtw_api_client/rpmtw_api_client.dart';

User user = User(...);
user.avatar(fontSize:20) // fontSize defaults to 18
```