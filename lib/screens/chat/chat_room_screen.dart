import 'package:carely/models/chat_room.dart';
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
  final List<ChatRoom> dummyChatRooms = [
    ChatRoom(
      memberId: 1,
      memberName: '김상덕',
      memberType: MemberType.family,
      chatroomId: 101,
      content: '형제들이여',
      createdAt: DateTime.now(),
      profileImage: '1',
    ),
    ChatRoom(
      memberId: 2,
      memberName: '이하늘',
      memberType: MemberType.volunteer,
      chatroomId: 102,
      content: '봉사는 사랑입니다',
      createdAt: DateTime.now().subtract(Duration(minutes: 10)),
      profileImage: '2',
    ),
    ChatRoom(
      memberId: 3,
      memberName: '최은정',
      memberType: MemberType.caregiver,
      chatroomId: 103,
      content: '오늘 실습 잘 다녀왔어요!',
      createdAt: DateTime.now().subtract(Duration(hours: 1)),
      profileImage: '3',
    ),
  ];

  final List<ChatRoom> groupChats = [
    ChatRoom(
      memberId: 4,
      memberName: '박성우',
      memberType: MemberType.family,
      chatroomId: 201,
      content: '내일 모임 장소 여기 어때요?',
      createdAt: DateTime.now().subtract(Duration(minutes: 3)),
      profileImage: '4',
    ),
    ChatRoom(
      memberId: 5,
      memberName: '조수민',
      memberType: MemberType.volunteer,
      chatroomId: 202,
      content: '간식 제가 준비할게요!',
      createdAt: DateTime.now().subtract(Duration(minutes: 20)),
      profileImage: '5',
    ),
    ChatRoom(
      memberId: 6,
      memberName: '이태연',
      memberType: MemberType.caregiver,
      chatroomId: 203,
      content: '모두들 건강 챙기세요~',
      createdAt: DateTime.now().subtract(Duration(hours: 2, minutes: 15)),
      profileImage: '6',
    ),
  ];

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
              child: ListView(
                children: [
                  Text(
                    '이웃 대화',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ..._buildChatRoomList(dummyChatRooms),
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
    return SizedBox(
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
