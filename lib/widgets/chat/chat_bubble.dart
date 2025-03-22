import 'package:carely/theme/colors.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final String content;
  final DateTime? timeStamp;
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
