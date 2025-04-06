import 'package:carely/theme/colors.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? initialValue;
  final ValueChanged<String> onChanged;

  const InputTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: initialValue);

    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          labelStyle: TextStyle(
            color: AppColors.gray500,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.gray300, fontSize: 20.0),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.gray200),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.gray600),
          ),
        ),
      ),
    );
  }
}
