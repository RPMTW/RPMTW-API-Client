import "dart:io";

import "package:rpmtw_api_client/rpmtw_api_client.dart";

void main() async {
  RPMTWApiClient.init(development: true); // Initialize RPMTW API Client
  RPMTWApiClient apiClient = RPMTWApiClient.instance;
  print(apiClient.apiBaseUrl);
  PasswordValidatedResult result =
      await apiClient.authResource.validPassword("12345"); // Valid password
  print(result.message);

  String message = await apiClient.otherResource.helloWorld();
  print(message);

  String ip = await apiClient.otherResource.getIP();
  print(ip);
  exit(0);
}
