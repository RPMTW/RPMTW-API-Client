import 'package:rpmtw_api_client/rpmtw_api_client.dart';

void main() async {
  RPMTWApiClient apiClient = RPMTWApiClient(development: true);
  User user =
      await apiClient.authResource.getUserByEmail("rrt467778@gmail.com");

  PasswordValidatedResult validatedResult =
      await apiClient.authResource.validPassword("abc");
  print(validatedResult.message);

  String token = await user.getToken("testPassword123");
  print(token);
}
