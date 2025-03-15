import 'package:carely/theme/colors.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String content;
  final VoidCallback onPressed;

  const DefaultButton({
    super.key,
    required this.content,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size(
          ScreenSize.width(context, 336),
          ScreenSize.height(context, 52),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        foregroundColor: Colors.white,
        backgroundColor: AppColors.mainPrimary,
        textStyle: const TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      child: Text(content),
    );
  }
}
