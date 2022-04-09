import 'dart:io';
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

  exit(0);
}
