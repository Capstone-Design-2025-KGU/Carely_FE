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
                  ChatRoomCard(
                    memberType: MemberType.family,
                    memberName: '김상덕',
                    content: '형제들이여',
                    timeStamp: '오전 07:00',
                  ),
                  SizedBox(height: 28.0),
                  ChatRoomCard(
                    memberType: MemberType.family,
                    memberName: '김상덕',
                    content: '형제들이여',
                    timeStamp: '오전 07:00',
                  ),
                  SizedBox(height: 28.0),
                  ChatRoomCard(
                    memberType: MemberType.family,
                    memberName: '김상덕',
                    content: '형제들이여',
                    timeStamp: '오전 07:00',
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
                  ChatRoomCard(
                    memberType: MemberType.family,
                    memberName: '김상덕',
                    content: '형제들이여',
                    timeStamp: '오전 07:00',
                  ),
                  SizedBox(height: 28.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ChatRoomCard extends StatelessWidget {
  MemberType memberType;
  String memberName;
  String content;
  String timeStamp;

  ChatRoomCard({
    super.key,
    required this.memberType,
    required this.memberName,
    required this.content,
    required this.timeStamp,
  });

  String get displayName {
    String role = '';
    switch (memberType) {
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
    return '$role $memberName님';
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
                      timeStamp,
                      style: TextStyle(
                        color: AppColors.gray500,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),

                Text(
                  content,
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
