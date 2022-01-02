import 'package:rpmtw_api_client/rpmtw_api_client.dart';

void main() async {
  RPMTWApiClient apiClient = RPMTWApiClient(development: true);
  User user = await apiClient.authResource
      .getUserByEmail("abcd@gmail.com");

  print(user.username);
}
