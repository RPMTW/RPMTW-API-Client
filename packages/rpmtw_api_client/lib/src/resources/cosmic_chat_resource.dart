import "dart:convert";

import "package:rpmtw_api_client/src/http/api_http_client.dart";
import "package:rpmtw_api_client/src/http/api_http_response.dart";
import "package:rpmtw_api_client/src/models/cosmic_chat/cosmic_chat_info.dart";
import "package:rpmtw_api_client/src/models/cosmic_chat/cosmic_chat_message.dart";
import "package:rpmtw_api_client/src/resources/base_resource.dart";
import "package:socket_io_client/socket_io_client.dart";

Socket? _socket;
bool _onlyListenMessage = false;

class CosmicChatResource extends APIResource {
  final String cosmicChatBaseUrl;

  CosmicChatResource(APIHttpClient httpClient,
      {required this.cosmicChatBaseUrl})
      : super(httpClient);

  bool get isConnected => _socket?.connected ?? false;

  /// Connect to the Cosmic Chat server
  ///
  /// * [minecraftUUID] player"s minecraft UUID (optional)
  /// * [token] rpmtw account token (optional)
  /// * [onlyListenMessage] if true, only listen to message event, [minecraftUUID] and [token] can be empty
  /// [minecraftUUID], [token] cannot both be empty
  Future<void> connect(
      {String? minecraftUUID,
      String? token,
      bool onlyListenMessage = false}) async {
    _onlyListenMessage = onlyListenMessage;
    final baseOption =
        OptionBuilder().setTransports(["websocket"]).disableAutoConnect();

    if (minecraftUUID == null && token == null && !onlyListenMessage) {
      throw ArgumentError("minecraftUUID and token cannot both be null");
    }

    if (minecraftUUID != null) {
      baseOption.setExtraHeaders({"minecraft_uuid": minecraftUUID});
    }
    if (token != null) {
      baseOption.setExtraHeaders({"rpmtw_auth_token": token});
    }

    Socket socket = io(cosmicChatBaseUrl, baseOption.build());
    print("Connecting to Cosmic Chat server...");
    bool connected = false;
    socket.onConnect((data) {
      print("Connected to Cosmic Chat server");
      connected = true;
    });
    socket = socket.connect();

    // Wait for connection
    while (!connected) {
      await Future.delayed(Duration(milliseconds: 100));
    }
    // Wait for the connection to be initialized finished
    await Future.delayed(Duration(milliseconds: 1000));

    _socket = socket;
  }

  /// Disconnect from the Cosmic Chat server
  void disconnect() {
    _socket?.disconnect();
    _socket?.clearListeners();
    _socket = null;
  }

  void _connectCheck({bool onlyListen = false}) {
    if (_socket == null && !onlyListen && !_onlyListenMessage) {
      throw StateError(
          "Not connected to the Cosmic Chat server, call connect() first");
    }
  }

  /// Send a message to the server, and return the sent status.
  ///
  /// **Parameters**
  /// * [message] message content
  /// * [nickname] user"s nickname
  Future<String> sendMessage(String message, {String? nickname}) async {
    _connectCheck();
    String? status;

    _socket!.emitWithAck(
        "clientMessage",
        utf8.encode(json.encode({
          "message": message,
          if (nickname != null) "nickname": nickname,
        })), ack: (_response) {
      Map response = json.decode(_response);
      status = response["status"];
    });

    while (status == null) {
      await Future.delayed(Duration(milliseconds: 100));
    }
    return status!;
  }

  /// Reply message by message uuid, and return the replied status.
  ///
  /// **Parameters**
  /// * [message] message content
  /// * [uuid] message uuid to reply to
  /// * [nickname] user"s nickname
  Future<String> replyMessage(String message,
      {required String uuid, String? nickname}) async {
    _connectCheck();
    String? status;

    _socket!.emitWithAck(
        "clientMessage",
        utf8.encode(json.encode({
          "message": message,
          if (nickname != null) "nickname": nickname,
          "replyMessageUUID": uuid
        })), ack: (_response) {
      Map response = json.decode(_response);
      status = response["status"];
    });

    while (status == null) {
      await Future.delayed(Duration(milliseconds: 100));
    }
    return status!;
  }

  /// Receive messages sent by other users
  Stream<CosmicChatMessage> get onMessageSent {
    _connectCheck(onlyListen: true);

    String decodeMessage(List<dynamic> message) =>
        utf8.decode(List<int>.from(message));

    Stream<CosmicChatMessage> stream = Stream.multi((p0) {
      _socket!.on("sentMessage", (data) {
        p0.add(CosmicChatMessage.fromJson(decodeMessage(data)));
      });
    });

    return stream;
  }

  /// Get message by message uuid
  Future<CosmicChatMessage> getMessage(String uuid) async {
    APIHttpResponse response = await httpClient.get("/cosmic-chat/view/$uuid");
    return CosmicChatMessage.fromMap(response.data);
  }

  /// Get cosmic chat info (online users, protocolVersion, etc.)
  Future<CosmicChatInfo> getInfo() async {
    APIHttpResponse response = await httpClient.get("/cosmic-chat/info");

    return CosmicChatInfo.fromMap(response.data);
  }
}
