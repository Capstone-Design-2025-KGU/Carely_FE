import 'package:carely/theme/colors.dart';
import 'package:flutter/material.dart';

class SignupProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String title;

  const SignupProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.title,
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
        const SizedBox(height: 36.0),
      ],
    );
  }
}
