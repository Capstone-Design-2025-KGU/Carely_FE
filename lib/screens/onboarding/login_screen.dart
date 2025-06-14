import 'package:carely/providers/member_provider.dart';
import 'package:carely/screens/nav_screen.dart';
import 'package:carely/screens/onboarding/term_screen.dart';
import 'package:carely/services/auth/auth_service.dart';
import 'package:carely/services/auth/token_storage_service.dart';
import 'package:carely/services/member/member_service.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:carely/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultButton(
              content: '테스터 계정으로 로그인',
              onPressed: () async {
                const testUsername = 'flutter';
                const testPassword = 'pass1';

                final token = await AuthService.instance.login(
                  testUsername,
                  testPassword,
                );

                if (token != null) {
                  await TokenStorageService.saveToken(token);
                  final member = await MemberService.instance.fetchMyInfo(
                    token,
                  );
                  if (member != null) {
                    Provider.of<MemberProvider>(
                      context,
                      listen: false,
                    ).setMember(member);
                    Navigator.pushReplacementNamed(context, NavScreen.id);
                  } else {
                    logger.e('멤버 정보를 찾을 수 없습니다');
                  }
                } else {
                  logger.e('토큰이 없습니다.');
                }
              },
            ),
            SizedBox(height: 20.0),
            DefaultButton(
              content: '조건희으로 로그인',
              onPressed: () async {
                const testUsername = 'user2';
                const testPassword = 'pass2';

                final token = await AuthService.instance.login(
                  testUsername,
                  testPassword,
                );

                if (token != null) {
                  await TokenStorageService.saveToken(token);
                  final member = await MemberService.instance.fetchMyInfo(
                    token,
                  );
                  if (member != null) {
                    Provider.of<MemberProvider>(
                      context,
                      listen: false,
                    ).setMember(member);
                    Navigator.pushReplacementNamed(context, NavScreen.id);
                  } else {
                    logger.e('멤버 정보를 찾을 수 없습니다');
                    await TokenStorageService.deleteToken();
                  }
                } else {
                  logger.e('토큰이 없습니다.');
                  await TokenStorageService.deleteToken();
                }
              },
            ),
            SizedBox(height: 20.0),
            DefaultButton(
              content: '회원 3으로 로그인',
              onPressed: () async {
                const testUsername = 'user3';
                const testPassword = 'pass3';

                final token = await AuthService.instance.login(
                  testUsername,
                  testPassword,
                );

                if (token != null) {
                  await TokenStorageService.saveToken(token);
                  final member = await MemberService.instance.fetchMyInfo(
                    token,
                  );
                  if (member != null) {
                    Provider.of<MemberProvider>(
                      context,
                      listen: false,
                    ).setMember(member);
                    Navigator.pushReplacementNamed(context, NavScreen.id);
                  } else {
                    logger.e('멤버 정보를 찾을 수 없습니다');
                    await TokenStorageService.deleteToken();
                  }
                } else {
                  logger.e('토큰이 없습니다.');
                  await TokenStorageService.deleteToken();
                }
              },
            ),
            SizedBox(height: 20.0),
            DefaultButton(
              content: '회원 4으로 로그인',
              onPressed: () async {
                const testUsername = 'user4';
                const testPassword = 'pass4';

                final token = await AuthService.instance.login(
                  testUsername,
                  testPassword,
                );

                if (token != null) {
                  await TokenStorageService.saveToken(token);
                  final member = await MemberService.instance.fetchMyInfo(
                    token,
                  );
                  if (member != null) {
                    Provider.of<MemberProvider>(
                      context,
                      listen: false,
                    ).setMember(member);
                    Navigator.pushReplacementNamed(context, NavScreen.id);
                  } else {
                    logger.e('멤버 정보를 찾을 수 없습니다');
                    await TokenStorageService.deleteToken();
                  }
                } else {
                  logger.e('토큰이 없습니다.');
                  await TokenStorageService.deleteToken();
                }
              },
            ),
            SizedBox(height: 20.0),
            DefaultButton(
              content: '회원가입 UI',
              onPressed: () async {
                Navigator.pushReplacementNamed(context, TermScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
