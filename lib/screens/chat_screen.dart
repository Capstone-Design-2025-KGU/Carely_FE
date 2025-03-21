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
          child: Column(
            children: [
              ChatBubble(content: '안녕하십니까?'),
              ChatBubble(content: '안녕하십니까?안녕하십니까?안녕하십니까?안녕하십니까?안녕하십니까?'),
              ChatBubble(content: 'Stand By Me'),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  String content;
  ChatBubble({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: ScreenSize.width(context, 200.0)),
      decoration: BoxDecoration(
        color: AppColors.mainPrimary,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Text(
          content,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
