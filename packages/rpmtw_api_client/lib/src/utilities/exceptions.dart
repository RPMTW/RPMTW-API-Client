class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(
      {this.message =
          "Unauthorized, please use RPMTWApiClient#setGlobalToken to set the authorization Token"});

  @override
  String toString() {
    return message;
  }
}
