import 'package:carely/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputSelectField extends StatelessWidget {
  final String label;
  final String hintText;
  final String displayText;
  final VoidCallback onTap;

  const InputSelectField({
    super.key,
    required this.label,
    this.displayText = '',
    required this.onTap,
    this.hintText = '선택해주세요',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: AppColors.gray500,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.gray300,
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.gray200),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.gray600),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                displayText.isEmpty ? hintText : displayText,
                style: TextStyle(
                  color:
                      displayText.isEmpty
                          ? AppColors.gray300
                          : AppColors.gray800,
                  fontSize: 20.0,
                ),
              ),

              FaIcon(
                FontAwesomeIcons.angleDown,
                size: 16.0,
                color: AppColors.gray300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
