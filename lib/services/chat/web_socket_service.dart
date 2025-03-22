import 'dart:convert';
import 'package:carely/models/chat_message.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class WebSocketService {
  late final StompClient _stompClient;
  final _url = dotenv.env['SERVER_URL'] ?? 'http://10.0.2.2:8080/ws';

  void connect({required void Function(ChatMessage) onMessage}) {
    _stompClient = StompClient(
      config: StompConfig.sockJS(
        url: '$_url/ws',
        onConnect: (frame) {
          logger.i('WebSocket 연결 성공');
          _subscribe(onMessage);
        },
        onWebSocketError: (error) => logger.e('WebSocket error: $error'),
      ),
    );
    _stompClient.activate();
  }

  void _subscribe(void Function(ChatMessage) onMessage) {
    _stompClient.subscribe(
      destination: '/topic/public',
      callback: (frame) {
        if (frame.body != null) {
          final message = ChatMessage.fromJson(jsonDecode(frame.body!));
          onMessage(message);
        }
      },
    );
  }

  void sendMessage(ChatMessage message) {
    _stompClient.send(
      destination: '/app/chat.sendMessage',
      body: jsonEncode(message.toJson()),
    );
  }

  void disconnect() {
    _stompClient.deactivate();
  }
}
