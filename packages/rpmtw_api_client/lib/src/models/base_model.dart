abstract class BaseModel {
  final String uuid;
  const BaseModel(this.uuid);

  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
