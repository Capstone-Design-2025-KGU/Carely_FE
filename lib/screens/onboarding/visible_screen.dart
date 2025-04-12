import 'dart:convert';

import 'package:carely/providers/member_provider.dart';
import 'package:carely/screens/onboarding/skill_screen.dart';
import 'package:carely/screens/onboarding/success_screen.dart';
import 'package:carely/services/member/member_service.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:carely/widgets/signup_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:carely/widgets/default_button.dart';
import 'package:provider/provider.dart';

class VisibleScreen extends StatefulWidget {
  static String id = 'verify-screen';
  const VisibleScreen({super.key});

  @override
  State<VisibleScreen> createState() => _VisibleScreenState();
}

class _VisibleScreenState extends State<VisibleScreen> {
  bool? _isVisible;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(title: '회원가입'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SignupProgressBar(
              currentStep: 6,
              title: '내 정보를 이웃에게 공유할까요?',
              isVerify: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RadioListTile<bool>(
                      title: const Text('네 좋아요!'),
                      value: true,
                      groupValue: _isVisible,
                      onChanged: (value) {
                        setState(() {
                          _isVisible = value;
                        });
                      },
                    ),
                    RadioListTile<bool>(
                      title: const Text('다음에 할게요'),
                      value: false,
                      groupValue: _isVisible,
                      onChanged: (value) {
                        setState(() {
                          _isVisible = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: DefaultButton(
                content: '다음',
                isEnable: _isVisible != null,
                onPressed: () async {
                  if (_isVisible == null) return;

                  final provider = context.read<MemberProvider>();
                  provider.updatePartial(isVisible: _isVisible!);
                  final member = provider.member;

                  if (member == null) {
                    logger.e('❌ 멤버 정보 없음');
                    return;
                  }

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
                      MaterialPageRoute(builder: (_) => const SuccessScreen()),
                    );
                  } else {
                    logger.e('❌ 회원가입 실패');
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
