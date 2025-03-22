import 'package:carely/models/chat_message.dart';
import 'package:carely/services/chat/chat_service.dart';
import 'package:carely/services/chat/web_socket_service.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:carely/widgets/chat/chat_bubble.dart';
import 'package:carely/widgets/chat/chat_time_stamp.dart';
import 'package:flutter/material.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat-screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final wsUrl = dotenv.env['SERVER_URL'] ?? 'http://10.0.2.2:8080/ws';
  final List<ChatMessage> _messages = [];
  final memberId = 1; // Test용 임시
  final chatRoomId = 1;

  late final WebSocketService _webSocektService;

  @override
  void initState() {
    super.initState();
    fetchPreviousMessages();
    _webSocektService = WebSocketService();
    _webSocektService.connect(
      onMessage: (msg) {
        setState(() {
          _messages.add(msg);
        });
      },
    );
  }

  void fetchPreviousMessages() async {
    try {
      final previous = await ChatService.instance.fetchMessages(chatRoomId);
      setState(() {
        _messages.addAll(previous);
      });
    } catch (e) {
      logger.e('채팅 내역을 불러올 수 없습니다 : $e');
    }
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
              final message = ChatMessage(
                senderId: memberId,
                chatroomId: 1,
                content: '성민이 보낸 테스트 메시지!',
                messageType: MessageType.CHAT,
              );
              _webSocektService.sendMessage(message);
            },
            child: Text('send mine'),
          ),
          TextButton(
            onPressed: () {
              final message = ChatMessage(
                senderId: 2,
                chatroomId: 1,
                content: '유저 2가 보낸 테스트 메시지!',
                messageType: MessageType.CHAT,
              );
              _webSocektService.sendMessage(message);
            },
            child: Text('send user 2'),
          ),
        ],
      ),
    );
  }
}
