import 'package:carely/models/chat_message.dart';
import 'package:carely/screens/chat/schedule_screen.dart';
import 'package:carely/services/chat/chat_service.dart';
import 'package:carely/services/chat/web_socket_service.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/widgets/chat/chat_bubble.dart';
import 'package:carely/widgets/chat/chat_time_stamp.dart';
import 'package:flutter/material.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final TextEditingController _controller = TextEditingController();
  final MemberType testMemberType = MemberType.family; // 여기서 타입 바꿔가며 테스트 가능

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

  Color getBackgroundColor(MemberType type) {
    switch (type) {
      case MemberType.family:
        return AppColors.main50;
      case MemberType.volunteer:
        return AppColors.blue100;
      case MemberType.caregiver:
        return AppColors.green100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(testMemberType), // 여기서 색상 적용!
      appBar: DefaultAppBar(
        title: widget.opponentName,
        color: getBackgroundColor(testMemberType),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScheduleScreen()),
              );
            },
            icon: FaIcon(FontAwesomeIcons.calendarCheck, size: 24.0),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: ListView(children: _buildChatItems()),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.gray50,
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                          hintText: '메세지를 입력해 주세요.',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.gray400,
                            fontSize: 16.0,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none, // 선 없애기
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    IconButton(
                      icon: Transform.rotate(
                        angle: -1.57, // 약 -90도 (라디안 단위)
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.gray100,
                          ),
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 16.0,
                          ),
                        ),
                      ),
                      color: AppColors.gray600, // 색 커스터마이징 가능
                      onPressed: () {
                        final text = _controller.text.trim();
                        if (text.isNotEmpty) {
                          final message = ChatMessage(
                            senderId: widget.senderId,
                            chatroomId: widget.chatRoomId,
                            content: text,
                            messageType: MessageType.CHAT,
                          );

                          _webSocektService.sendMessage(message);

                          _controller.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(color: Colors.white, height: 36.0),
          // TextButton(
          //   onPressed: () {
          //     final message = ChatMessage(
          //       senderId: widget.senderId,
          //       chatroomId: widget.chatRoomId,
          //       content: '성민이 보낸 테스트 메시지!',
          //       messageType: MessageType.CHAT,
          //     );
          //     _webSocektService.sendMessage(message);
          //   },
          //   child: Text('send mine'),
          // ),
          // TextButton(
          //   onPressed: () {
          //     final message = ChatMessage(
          //       senderId: 2,
          //       chatroomId: widget.chatRoomId,
          //       content: '유저 2가 보낸 테스트 메시지!',
          //       messageType: MessageType.CHAT,
          //     );
          //     _webSocektService.sendMessage(message);
          //   },
          //   child: Text('send user 2'),
          // ),
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
