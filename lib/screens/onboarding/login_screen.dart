import 'package:carely/screens/nav_screen.dart';
import 'package:carely/services/auth/auth_service.dart';
import 'package:carely/services/auth/token_storage_service.dart';
import 'package:carely/widgets/default_button.dart';
import 'package:flutter/material.dart';

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
        child: DefaultButton(
          content: '테스터 계정으로 로그인',
          onPressed: () async {
            const testUsername = 'flutter';
            const testPassword = '1234';

            final token = await AuthService.instance.login(
              testUsername,
              testPassword,
            );

            if (token != null) {
              await TokenStorageService.saveToken(token);

              Navigator.pushReplacementNamed(context, NavScreen.id);
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('로그인 실패!')));
            }
          },
        ),
      ),
    );
  }
}
