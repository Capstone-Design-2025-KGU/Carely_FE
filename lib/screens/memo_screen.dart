import 'package:carely/theme/colors.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MemoScreen extends StatefulWidget {
  const MemoScreen({super.key});

  @override
  State<MemoScreen> createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: ''),
      body: SingleChildScrollView(child: AICard()),
    );
  }
}

class AICard extends StatelessWidget {
  const AICard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 400.0,
          decoration: BoxDecoration(),
          child: Image.asset(
            'assets/images/mesh-gradient.png',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset('assets/images/carely-ai.svg', width: 120.0),
                  Text(
                    '전체 요약',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      color: AppColors.mainPrimary,
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    IconButton(imagePath: 'all', onPressed: () {}),
                    IconButton(imagePath: 'temperature', onPressed: () {}),
                    IconButton(imagePath: 'all', onPressed: () {}),
                    IconButton(imagePath: 'all', onPressed: () {}),
                    IconButton(imagePath: 'all', onPressed: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class IconButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const IconButton({
    super.key,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      child: Image.asset(
        'assets/images/family/skills/$imagePath.png',
        width: 60.0,
        height: 60.0,
      ),
    );
  }
}
