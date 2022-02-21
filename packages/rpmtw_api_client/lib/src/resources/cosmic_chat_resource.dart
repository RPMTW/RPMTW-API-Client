import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:rpmtw_api_client/src/models/cosmic_chat/cosmic_chat_info.dart';
import 'package:rpmtw_api_client/src/models/cosmic_chat/cosmic_chat_message.dart';
import 'package:rpmtw_api_client/src/resources/base_resource.dart';
import 'package:rpmtw_api_client/src/utilities/exceptions.dart';
import 'package:rpmtw_api_client/src/utilities/extension.dart';
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

  void _connectCheck() {
    if (_socket == null) {
      throw StateError(
          'Not connected to the Cosmic Chat server, call connect() first');
    }
  }

  /// Send a message to the server
  ///
  /// **Parameters**
  /// * [message] message content
  /// * [nickname] user's nickname
  void sendMessage(String message, {String? nickname}) {
    _connectCheck();

    _socket!.emit(
        'clientMessage',
        utf8.encode(json.encode({
          'message': 'Hello, world!',
          if (nickname != null) 'nickname': nickname,
        })));
  }

  /// Reply message by message id
  ///
  /// **Parameters**
  /// * [message] message content
  /// * [uuid] message uuid to reply to
  /// * [nickname] user's nickname
  void replyMessage(String message, {required String uuid, String? nickname}) {
    _connectCheck();

    _socket!.emit(
        'clientMessage',
        utf8.encode(json.encode({
          'message': 'Hello, world!',
          if (nickname != null) 'nickname': nickname,
          "replyMessageUUID": uuid
        })));
  }

  /// Receive messages sent by other users
  Stream<CosmicChatMessage> get onMessageSent {
    _connectCheck();

    String decodeMessage(List<dynamic> message) =>
        utf8.decode(List<int>.from(message));

    Stream<CosmicChatMessage> stream = Stream.multi((p0) {
      _socket!.on("sentMessage", (data) {
        p0.add(CosmicChatMessage.fromJson(decodeMessage(data)));
      });
    });

    return stream;
  }

  Future<CosmicChatMessage> getMessage(String uuid) async {
    Response response =
        await httpClient.get(Uri.parse("$apiBaseUrl/cosmic-chat/view/$uuid"));
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      return CosmicChatMessage.fromMap(response.map['data']);
    } else if (statusCode == HttpStatus.notFound) {
      throw ModelNotFoundException<CosmicChatMessage>();
    } else {
      throw Exception('Get message failed');
    }
  }

  Future<CosmicChatInfo> getInfo() async {
    Response response =
        await httpClient.get(Uri.parse("$apiBaseUrl/cosmic-chat/info"));
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      return CosmicChatInfo.fromMap(response.map['data']);
    } else if (statusCode == HttpStatus.notFound) {
      throw ModelNotFoundException<CosmicChatInfo>();
    } else {
      throw Exception('Get info failed');
    }
  }
}
