import 'package:carely/theme/colors.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:flutter/material.dart';

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
