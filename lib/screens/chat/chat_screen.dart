import 'package:carely/models/chat_message.dart';
import 'package:carely/providers/member_provider.dart';
import 'package:carely/screens/chat/schedule_screen.dart';
import 'package:carely/services/chat/chat_service.dart';
import 'package:carely/services/chat/web_socket_service.dart';
import 'package:carely/services/meeting_service.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:carely/utils/member_color.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:carely/widgets/chat/chat_bubble.dart';
import 'package:carely/widgets/chat/chat_time_stamp.dart';
import 'package:flutter/material.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat-screen';
  final int chatRoomId;
  final int senderId; // 현재 로그인한 사용자의 Id
  final int opponentMemberId;
  final String opponentName;

  const ChatScreen({
    super.key,
    required this.chatRoomId,
    required this.senderId,
    required this.opponentName,
    required this.opponentMemberId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final wsUrl = dotenv.env['SERVER_URL'] ?? 'http://10.0.2.2:8080/ws';
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPreviousMessages();
    WebSocketService.instance.connect(
      chatRoomId: widget.chatRoomId,
      onMessage: (msg) {
        if (!mounted) return;
        setState(() {
          _messages.add(msg);
        });
      },
    );
  }

  @override
  void dispose() {
    WebSocketService.instance.disconnect();
    _controller.dispose();
    super.dispose();
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
    final memberType =
        Provider.of<MemberProvider>(context).member?.memberType ??
        MemberType.family;

    return Scaffold(
      backgroundColor: getBackgroundColor(memberType),
      appBar: DefaultAppBar(
        title: widget.opponentName,
        color: getBackgroundColor(memberType),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ScheduleScreen(
                        chatRoomId: widget.chatRoomId,
                        opponentMemberId: widget.opponentMemberId,
                      ),
                ),
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

                          WebSocketService.instance.sendMessage(message);

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

      if (message.messageType == MessageType.MEETING_REQUEST) {
        chatItems.add(
          MeetingMessageBubble(
            message: message,
            isMine: message.senderId == widget.senderId,
            timeStamp: message.createdAt,
          ),
        );
      } else {
        chatItems.add(
          ChatBubble(
            content: message.content,
            isMine: message.senderId == widget.senderId,
            timeStamp: message.createdAt,
          ),
        );
      }
    }
    return chatItems;
  }
}

class MeetingMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final DateTime? timeStamp;
  final bool isMine;

  const MeetingMessageBubble({
    super.key,
    required this.message,
    this.timeStamp,
    required this.isMine,
  });

  @override
  Widget build(BuildContext context) {
    final bubble = Container(
      constraints: BoxConstraints(maxWidth: ScreenSize.width(context, 220.0)),
      decoration: BoxDecoration(
        color: AppColors.mainPrimary,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '약속 요청을 보냈어요!',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              message.content ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     TextButton(
            //       onPressed: () => _respondMeeting(context, true),
            //       child: Text('수락', style: TextStyle(color: Colors.green)),
            //     ),
            //     TextButton(
            //       onPressed: () => _respondMeeting(context, false),
            //       child: Text('거절', style: TextStyle(color: Colors.red)),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );

    final formattedTime =
        timeStamp != null ? DateFormat('HH:mm').format(timeStamp!) : '';
    final time = Text(
      formattedTime,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.gray600,
        fontSize: 12.0,
      ),
    );

    return Row(
      mainAxisAlignment:
          isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children:
          isMine
              ? [time, SizedBox(width: 6.0), bubble]
              : [bubble, SizedBox(width: 6.0), time],
    );
  }

  void _respondMeeting(BuildContext context, bool isAccepted) async {
    try {
      if (message.meetingId == null) {
        throw Exception('Meeting ID가 없습니다.');
      }
      final memberProvider = Provider.of<MemberProvider>(
        context,
        listen: false,
      );
      final currentMember = memberProvider.member;
      if (currentMember == null) return;

      await MeetingService.instance.respondMeeting(
        meetingId: message.meetingId!,
        accept: isAccepted,
        chatRoomId: message.chatroomId,
        senderId: currentMember.memberId,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isAccepted ? '약속 수락 완료' : '약속 거절 완료')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('에러 발생: $e')));
    }
  }
}
