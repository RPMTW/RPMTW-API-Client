class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(
      {this.message =
          'Unauthorized, please use RPMTWApiClient#setGlobalToken to set the authorization Token'});

  @override
  String toString() {
    return message;
  }
}

class ModelNotFoundException<T> implements Exception {
  final String? modelName;

  ModelNotFoundException({this.modelName});

  @override
  String toString() {
    return '${modelName ?? T.toString()} not found';
  }
}

class ClientUninitializedException implements Exception {
  final String message;

  ClientUninitializedException(
      {this.message =
          'Client is not initialized, please call RPMTWApiClient.init() first'});

  @override
  String toString() {
    return message;
  }
}
