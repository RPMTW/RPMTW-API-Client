import 'dart:convert';

import 'package:http/http.dart';
import 'package:rpmtw_api_client/src/models/cosmic_chat/cosmic_chat_message.dart';
import 'package:rpmtw_api_client/src/resources/base_resource.dart';
import 'package:socket_io_client/socket_io_client.dart';

Socket? _socket;

class CosmicChatResource extends BaseResource {
  final String cosmicChatBaseUrl;

  CosmicChatResource(
      {required Client httpClient,
      required String apiBaseUrl,
      required this.cosmicChatBaseUrl,
      required String? token})
      : super(
            httpClient: httpClient, apiBaseUrl: apiBaseUrl, globalToken: token);

  /// Connect to the Cosmic Chat server
  ///
  /// * [minecraftUUID] player's minecraft UUID (optional)
  /// * [token] rpmtw account token (optional)
  /// [minecraftUUID], [token] cannot both be empty
  Future<void> connect({String? minecraftUUID, String? token}) async {
    final baseOption =
        OptionBuilder().setTransports(['websocket']).disableAutoConnect();

    if (minecraftUUID == null && token == null) {
      throw ArgumentError('minecraftUUID and token cannot both be empty');
    }

    if (minecraftUUID != null) {
      baseOption.setExtraHeaders({"minecraft_uuid": minecraftUUID});
    }
    if (token != null) {
      baseOption.setExtraHeaders({"rpmtw_auth_token": token});
    }

    Socket socket = io(cosmicChatBaseUrl, baseOption.build());
    print('Connecting to Cosmic Chat server...');
    bool connected = false;
    socket.onConnect((data) {
      print('Connected to Cosmic Chat server');
      connected = true;
    });
    socket = socket.connect();

    // Wait for connection
    while (!connected) {
      await Future.delayed(Duration(milliseconds: 300));
    }
    _socket = socket;
  }

  /// Disconnect from the Cosmic Chat server
  void disconnect() {
    _socket?.disconnect();
    _socket?.clearListeners();
    _socket = null;
  }

  /// Send a message to the Cosmic Chat server
  void sendMessage(String message, {String? nickname}) {
    if (_socket == null) {
      throw StateError(
          'Not connected to the Cosmic Chat server, call connect() first');
    }

    _socket!.emit(
        'clientMessage',
        utf8.encode(json.encode({
          'message': 'Hello, world!',
          if (nickname != null) 'nickname': nickname,
        })));
  }

  /// Receive messages sent by other users
  Stream<CosmicChatMessage> get onMessageSent {
    if (_socket == null) {
      throw StateError(
          'Not connected to the Cosmic Chat server, call connect() first');
    }

    String decodeMessage(List<dynamic> message) =>
        utf8.decode(List<int>.from(message));

    Stream<CosmicChatMessage> stream = Stream.multi((p0) {
      _socket!.on("sentMessage", (data) {
        p0.add(CosmicChatMessage.fromJson(decodeMessage(data)));
      });
    });

    return stream;
  }
}
