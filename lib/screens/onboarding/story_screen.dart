import 'package:carely/screens/onboarding/success_screen.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:carely/widgets/signup_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:carely/widgets/default_button.dart';

class StoryScreen extends StatefulWidget {
  static String id = 'story-screen';
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final TextEditingController _controller = TextEditingController();
  final int maxLength = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(title: '회원가입'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SignupProgressBar(
              currentStep: 5,
              title: '나의 이야기를 들려주세요',
              isStory: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32.0),
                    Text(
                      '나의 이야기',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray400,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        TextField(
                          controller: _controller,
                          maxLines: 8,
                          maxLength: maxLength,
                          cursorColor: AppColors.gray300,
                          style: const TextStyle(fontSize: 16.0),
                          decoration: InputDecoration(
                            hintText: '편하게 나의 이야기를 들려주세요! (1,000자 이내)',
                            hintStyle: const TextStyle(
                              color: Color(0xFFC5C9D1), // 연한 회색
                              fontSize: 16,
                            ),
                            counterText: '', // 하단 기본 카운터 제거
                            contentPadding: const EdgeInsets.all(16.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: AppColors.gray100, // 테두리 색
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: AppColors.gray100,
                              ),
                            ),
                          ),
                          onChanged: (_) {
                            setState(() {}); // 글자 수 업데이트
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 16.0,
                            bottom: 12.0,
                          ),
                          child: Text(
                            '${_controller.text.length}/$maxLength',
                            style: const TextStyle(
                              color: AppColors.gray300,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: DefaultButton(
                content: '다음',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SuccessScreen()),
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
