import 'package:carely/theme/colors.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:flutter/material.dart';

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
      body: NoChatRoomWidget(),
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
            image: AssetImage('assets/images/no_chat_room.png'),
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
