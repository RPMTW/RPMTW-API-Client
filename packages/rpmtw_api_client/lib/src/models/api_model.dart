abstract class APIModel {
  final String uuid;
  const APIModel(this.uuid);

  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
