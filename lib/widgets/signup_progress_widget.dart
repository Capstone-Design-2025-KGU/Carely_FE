import 'package:carely/theme/colors.dart';
import 'package:flutter/material.dart';

class SignupProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps = 7;
  final String title;
  final bool isStory;
  final bool isVerify;

  const SignupProgressBar({
    super.key,
    required this.currentStep,
    required this.title,
    this.isStory = false,
    this.isVerify = false,
  });

  @override
  Widget build(BuildContext context) {
    double progress = currentStep / totalSteps;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            color: AppColors.mainPrimary,
            minHeight: 4,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        if (isStory)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              '다른 이웃에게 이야기가 보여줘요',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: AppColors.gray600,
              ),
            ),
          ),
        if (isVerify)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              '다른 이웃에게 내 이름, 나이 정보가 지도에 공유되어요!',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: AppColors.gray600,
              ),
            ),
          ),
        const SizedBox(height: 36.0),
      ],
    );
  }
}
