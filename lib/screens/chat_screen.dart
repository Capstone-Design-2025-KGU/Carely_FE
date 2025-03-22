import 'dart:convert';

import 'package:carely/models/chat_message.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:flutter/material.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

// 서버에서 DB저장 및 Timestamp찍는 것으로 바뀌면 그거 테스트.
// 그 다음 원하는 텍스트 입력 추가.

class ChatScreen extends StatefulWidget {
  static String id = 'chat-screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  late StompClient stompClient;
  final memberId = 1; // Test용 임시

  @override
  void initState() {
    super.initState();
    initWebSocket();
  }

  void initWebSocket() {
    stompClient = StompClient(
      config: StompConfig.sockJS(
        url: 'http://10.0.2.2:8080/ws',
        onConnect: onConnectCallback,
        onWebSocketError: (error) => logger.i('WebSocket error: $error'),
      ),
    );
    stompClient.activate();
  }

  void onConnectCallback(StompFrame frame) {
    logger.i('WebSocket 연결 성공');

    // 구독
    stompClient.subscribe(
      destination: '/topic/public',
      callback: (frame) {
        if (frame.body != null) {
          final data = jsonDecode(frame.body!);
          final message = ChatMessage.fromJson(data);
          logger.i('수신된 메시지: $message');

          setState(() {
            _messages.add(message);
          });
        }
      },
    );

    // 메시지 전송 테스트
    stompClient.send(
      destination: '/app/chat.sendMessage',
      body: jsonEncode({
        'senderId': 10,
        'chatroomId': 1,
        'content': 'Flutter에서 보낸 테스트 메시지!',
        'messageType': 'CHAT',
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: '( ) 님과의 채팅방'),
      body: Column(
        children: [
          ChatTimeStamp(timeStamp: '2025년 03월 21일'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return ChatBubble(
                    content: message.content,
                    isMine: message.senderId == memberId,
                    timeStamp: message.createdAt,
                  );
                },
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              stompClient.send(
                destination: '/app/chat.sendMessage',
                body: jsonEncode({
                  'senderId': memberId,
                  'chatroomId': 1,
                  'content': '성민이 보낸 테스트 메시지!',
                  'messageType': 'CHAT',
                }),
              );
            },
            child: Text('send!'),
          ),
        ],
      ),
    );
  }
}

class ChatTimeStamp extends StatelessWidget {
  final String timeStamp;
  const ChatTimeStamp({super.key, required this.timeStamp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Align(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.width(context, 200.0),
          ),
          decoration: BoxDecoration(
            color: AppColors.gray700,
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Text(
              timeStamp,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String content;
  final DateTime timeStamp;
  final bool isMine;

  const ChatBubble({
    super.key,
    required this.content,
    required this.isMine,
    required this.timeStamp,
  });

  @override
  Widget build(BuildContext context) {
    // Message Bubble
    final bubble = Container(
      constraints: BoxConstraints(maxWidth: ScreenSize.width(context, 200.0)),
      decoration: BoxDecoration(
        color: isMine ? AppColors.mainPrimary : Colors.white,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Text(
          content,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
            color: isMine ? Colors.white : AppColors.gray800,
          ),
        ),
      ),
    );

    // Time Stamp
    final formattedTime = DateFormat('HH:mm').format(timeStamp);
    final time = Text(
      formattedTime,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.gray600,
        fontSize: 12.0,
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment:
            isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children:
            isMine
                ? [time, SizedBox(width: 6.0), bubble]
                : [bubble, SizedBox(width: 6.0), time],
      ),
    );
  }
}
