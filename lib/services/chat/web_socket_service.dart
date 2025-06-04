import 'dart:convert';
import 'package:carely/models/chat_message.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class WebSocketService {
  // ✅ 싱글톤 인스턴스
  WebSocketService._privateConstructor();
  static final WebSocketService instance =
      WebSocketService._privateConstructor();

  final String _url = dotenv.env['WEBSOCKET_URL'] ?? 'http://10.0.2.2:8080/ws';

  StompClient? _stompClient; // ✅ nullable로 변경 (초기엔 null)

  bool get isConnected => _stompClient?.connected == true; // 연결 여부 체크

  void connect({
    required int chatRoomId,
    required void Function(ChatMessage) onMessage,
  }) {
    if (isConnected) {
      logger.i('이미 WebSocket에 연결되어 있음');
      _subscribe(chatRoomId, onMessage);
      return;
    }

    _stompClient = StompClient(
      config: StompConfig.sockJS(
        url: '$_url/ws',
        onConnect: (frame) {
          logger.i('WebSocket 연결 성공');
          _subscribe(chatRoomId, onMessage);
        },
        onWebSocketError: (error) => logger.e('WebSocket error: $error'),
      ),
    );

    _stompClient!.activate();
  }

  void _subscribe(int chatRoomId, void Function(ChatMessage) onMessage) {
    final destination = '/topic/chatroom/$chatRoomId';
    logger.i('[WS] 구독 시작: $destination');
    _stompClient?.subscribe(
      destination: destination,
      callback: (frame) {
        logger.i('[WS] 수신된 메시지: ${frame.body}');
        if (frame.body != null) {
          final message = ChatMessage.fromJson(jsonDecode(frame.body!));
          onMessage(message);
        }
      },
    );
  }

  void sendMessage(ChatMessage message) {
    if (!isConnected) {
      logger.w('WebSocket이 연결되어 있지 않아 메시지를 보낼 수 없음');
      return;
    }
    _stompClient!.send(
      destination: '/app/chat.sendMessage',
      body: jsonEncode(message.toJson()),
    );
    logger.i(message.toJson());
  }

  void disconnect() {
    _stompClient?.deactivate();
    _stompClient = null;
  }
}
