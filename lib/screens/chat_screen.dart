import 'package:carely/utils/member_type.dart';
import 'package:flutter/material.dart';

import 'package:carely/theme/colors.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:carely/widgets/default_app_bar.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat-screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: '( ) 님과의 채팅방'),
      body: Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                ChatTimeStamp(timeStamp: '2025년 03월 21일'),
                ChatBubble(
                  content: '안녕하십니까?',
                  isMine: true,
                  timeStamp: '18:57',
                ),
                ChatBubble(
                  content: '안녕하십니까?안녕하십니까?안녕하십니까?안녕하십니까?안녕하십니까?',
                  isMine: false,
                  timeStamp: '19:00',
                ),
                ChatBubble(
                  content: 'Stand By Me',
                  isMine: true,
                  timeStamp: '20:10',
                ),
              ],
            ),
          ),
        ),
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
  final String timeStamp;
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
    final time = Text(
      timeStamp,
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
