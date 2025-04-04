import 'package:carely/models/chat_room.dart';
import 'package:provider/provider.dart';
import 'package:carely/providers/member_provider.dart';
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
  List<ChatRoom> chatRooms = [];
  List<ChatRoom> neighborChats = [];
  List<ChatRoom> groupChats = [];

  Future<void> loadChatRoom(int memberId) async {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentMember =
          Provider.of<MemberProvider>(context, listen: false).currentMember;
      if (currentMember != null) {
        loadChatRoom(currentMember.memberId);
      }
    });
  }

  List<Widget> _buildChatRoomList(List<ChatRoom> chats, int senderId) {
    final List<Widget> widgets = [];
    for (int i = 0; i < chats.length; i++) {
      widgets.add(
        ChatRoomCard(
          chatRoom: chats[i],
          senderId: senderId,
          onChatUpdated: () {
            final memberId =
                Provider.of<MemberProvider>(
                  context,
                  listen: false,
                ).currentMember?.memberId;
            if (memberId != null) {
              loadChatRoom(memberId);
            }
          },
        ),
      );
      if (i != chats.length - 1) {
        widgets.add(SizedBox(height: 28.0));
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final currentMember = Provider.of<MemberProvider>(context).currentMember;
    final senderId = currentMember?.memberId;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '채팅',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
      ),
      body:
          senderId == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 24.0,
                      ),
                      child: RefreshIndicator(
                        onRefresh: () => loadChatRoom(senderId),
                        color: AppColors.gray900,
                        backgroundColor: AppColors.gray100,
                        child: ListView(
                          children:
                              chatRooms.isEmpty
                                  ? [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.2,
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
                                    ..._buildChatRoomList(
                                      neighborChats,
                                      senderId,
                                    ),
                                    SizedBox(height: 32.0),
                                    Text(
                                      '모임 대화',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    ..._buildChatRoomList(groupChats, senderId),
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
  final int senderId;
  final VoidCallback onChatUpdated;

  const ChatRoomCard({
    super.key,
    required this.chatRoom,
    required this.onChatUpdated,
    required this.senderId,
  });

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

  String _getProfileImagePath(MemberType memberType, String? profileImage) {
    final type = memberType.name;
    final imageName = profileImage ?? '1';
    return 'assets/images/$type/profile/$imageName.png';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ChatScreen(
                  chatRoomId: chatRoom.chatRoomId,
                  senderId: senderId,
                  opponentName: displayName,
                ),
          ),
        ).then((_) => onChatUpdated());
      },
      child: SizedBox(
        height: ScreenSize.height(context, 48.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(
                _getProfileImagePath(
                  chatRoom.memberType,
                  chatRoom.profileImage,
                ),
              ),
              width: 48.0, // 필요 시 사이즈 조절
              height: 48.0,
            ),
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
