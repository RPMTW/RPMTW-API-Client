class CosmicChatInfo {
  /// Number of online users.
  final int onlineUsers;

  /// Protocol version. (current version is 1)
  final int protocolVersion;

  CosmicChatInfo({
    required this.onlineUsers,
    required this.protocolVersion,
  });

  Map<String, dynamic> toMap() {
    return {
      'onlineUsers': onlineUsers,
      'protocolVersion': protocolVersion,
    };
  }

  factory CosmicChatInfo.fromMap(Map<String, dynamic> map) {
    return CosmicChatInfo(
      onlineUsers: map['onlineUsers']?.toInt() ?? 0,
      protocolVersion: map['protocolVersion']?.toInt() ?? 0,
    );
  }
}
