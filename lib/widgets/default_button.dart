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
    return TextButton(onPressed: onPressed, child: Text(content));
  }
}
