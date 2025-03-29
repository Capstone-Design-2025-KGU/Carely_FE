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

  final int chatRoomId;
  final int senderId; // 현재 로그인한 사용자의 Id
  final String opponentName;

  const ChatScreen({
    super.key,
    required this.chatRoomId,
    required this.senderId,
    required this.opponentName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final wsUrl = dotenv.env['SERVER_URL'] ?? 'http://10.0.2.2:8080/ws';
  final List<ChatMessage> _messages = [];

  late final WebSocketService _webSocektService;

  @override
  void initState() {
    super.initState();
    fetchPreviousMessages();
    _webSocektService = WebSocketService();
    _webSocektService.connect(
      chatRoomId: widget.chatRoomId,
      onMessage: (msg) {
        setState(() {
          _messages.add(msg);
        });
      },
    );
  }

  void fetchPreviousMessages() async {
    try {
      final previous = await ChatService.instance.fetchMessages(
        widget.chatRoomId,
      );
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
      appBar: DefaultAppBar(title: widget.opponentName),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(children: _buildChatItems()),
            ),
          ),
          TextButton(
            onPressed: () {
              final message = ChatMessage(
                senderId: widget.senderId,
                chatroomId: widget.chatRoomId,
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
                chatroomId: widget.chatRoomId,
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

  List<Widget> _buildChatItems() {
    final List<Widget> chatItems = [];
    DateTime? lastDate;

    for (final message in _messages) {
      final currentDate = DateTime(
        message.createdAt!.year,
        message.createdAt!.month,
        message.createdAt!.day,
      );

      if (lastDate == null || currentDate != lastDate) {
        chatItems.add(
          ChatTimeStamp(
            timeStamp:
                '${currentDate.year}년 ${currentDate.month.toString().padLeft(2, '0')}월 ${currentDate.day.toString().padLeft(2, '0')}일',
          ),
        );
        lastDate = currentDate;
      }

      chatItems.add(
        ChatBubble(
          content: message.content,
          isMine: message.senderId == widget.senderId,
          timeStamp: message.createdAt,
        ),
      );
    }
    return chatItems;
  }
}
