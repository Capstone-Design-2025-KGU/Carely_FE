import 'package:carely/models/chat_room.dart';
import 'package:carely/screens/chat/chat_screen.dart';
import 'package:carely/services/chat/chat_service.dart';
import 'package:carely/utils/member_type.dart';
import 'package:flutter/material.dart';

import 'package:carely/theme/colors.dart';
import 'package:carely/utils/screen_size.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final int memberId = 1; // Test 아이디
  List<ChatRoom> chatRooms = [];
  List<ChatRoom> neighborChats = [];
  List<ChatRoom> groupChats = [];

  Future<void> loadChatRoom() async {
    final allChats = await ChatService.instance.fetchChatRoom(memberId);
    setState(() {
      chatRooms = allChats;

      neighborChats =
          allChats.where((chat) => chat.participantCount == 2).toList();
      groupChats = allChats.where((chat) => chat.participantCount > 2).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadChatRoom();
  }

  List<Widget> _buildChatRoomList(List<ChatRoom> chats) {
    final List<Widget> widgets = [];
    for (int i = 0; i < chats.length; i++) {
      widgets.add(ChatRoomCard(chatRoom: chats[i]));
      if (i != chats.length - 1) {
        widgets.add(SizedBox(height: 28.0));
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '채팅',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 24.0,
              ),
              child: RefreshIndicator(
                onRefresh: loadChatRoom,
                color: AppColors.gray900,
                backgroundColor: AppColors.gray100,
                child: ListView(
                  children:
                      chatRooms.isEmpty
                          ? [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                            ),
                            Center(child: NoChatRoomWidget()),
                          ]
                          : [
                            Text(
                              '이웃 대화',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            ..._buildChatRoomList(neighborChats),
                            SizedBox(height: 32.0),
                            Text(
                              '모임 대화',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            ..._buildChatRoomList(groupChats),
                          ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatRoomCard extends StatelessWidget {
  final ChatRoom chatRoom;

  const ChatRoomCard({super.key, required this.chatRoom});

  String get displayName {
    String role = '';
    switch (chatRoom.memberType) {
      case MemberType.family:
        role = '간병인';
        break;
      case MemberType.volunteer:
        role = '자원봉사자';
        break;
      case MemberType.caregiver:
        role = '예비 요양보호사';
        break;
    }
    return '$role ${chatRoom.memberName}님';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ChatScreen(
                  chatRoomId: chatRoom.chatRoomId,
                  senderId: 1, // Test 현재 로그인한 사용자 Id
                  opponentName: displayName,
                ),
          ),
        );
      },
      child: SizedBox(
        height: ScreenSize.height(context, 48.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage('assets/images/temp-user-image.png')),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        displayName,
                        style: TextStyle(
                          color: AppColors.gray800,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        _formatTime(chatRoom.createdAt),
                        style: TextStyle(
                          color: AppColors.gray500,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    chatRoom.content,
                    style: TextStyle(
                      color: AppColors.gray500,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    // 예: 오전 7:00 형식으로 포맷
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final isAm = hour < 12;
    final formattedHour =
        hour == 0
            ? 12
            : hour > 12
            ? hour - 12
            : hour;
    return '${isAm ? "오전" : "오후"} $formattedHour:$minute';
  }
}

class NoChatRoomWidget extends StatelessWidget {
  const NoChatRoomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image(
            image: AssetImage('assets/images/no-chat-room.png'),
            width: ScreenSize.width(context, 248.0),
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          '아직 채팅방이 없어요. \n 이웃과 함께 따뜻한 대화를 시작해보세요!',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: AppColors.gray300,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
