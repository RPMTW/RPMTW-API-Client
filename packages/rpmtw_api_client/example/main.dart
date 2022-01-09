import 'package:rpmtw_api_client/rpmtw_api_client.dart';

void main() async {
  RPMTWApiClient.init(development: true);
  RPMTWApiClient apiClient = RPMTWApiClient.lastInstance;
  print(apiClient.baseUrl);
  PasswordValidatedResult result =
      await apiClient.authResource.validPassword("12345");
  print(result.message);
}
