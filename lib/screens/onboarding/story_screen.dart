import 'dart:convert';

import 'package:carely/providers/member_provider.dart';
import 'package:carely/screens/onboarding/success_screen.dart';
import 'package:carely/services/member/member_service.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:carely/widgets/signup_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:carely/widgets/default_button.dart';
import 'package:provider/provider.dart';

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
                          onChanged: (text) {
                            context.read<MemberProvider>().updatePartial(
                              story: text,
                            );
                            setState(() {});
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
                onPressed: () async {
                  final memberProvider = context.read<MemberProvider>();
                  final member = memberProvider.member;

                  if (member == null) {
                    logger.e('❌ 멤버 정보 없음');
                    return;
                  }

                  // 마지막 story 필드 업데이트
                  memberProvider.updatePartial(story: _controller.text);

                  // member 정보 전체 로그 출력
                  final memberJson = member.toJson();
                  logger.i('📦 회원가입 요청 데이터:');
                  logger.i(
                    const JsonEncoder.withIndent('  ').convert(memberJson),
                  );

                  final response = await MemberService.instance.register(
                    member,
                  );

                  if (response) {
                    logger.i('✅ 회원가입 성공');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SuccessScreen(),
                      ),
                    );
                  } else {
                    logger.e('❌ 회원가입 실패');
                    // 오류 처리 팝업 등을 띄울 수 있음
                  }
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
