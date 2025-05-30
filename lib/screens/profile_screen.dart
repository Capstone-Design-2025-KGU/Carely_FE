import 'package:carely/screens/onboarding/login_screen.dart';
import 'package:carely/services/auth/token_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:carely/widgets/default_button.dart';

class ProfileScreen extends StatelessWidget {
  static String id = 'profile-screen';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('프로필'), centerTitle: true),
      body: Center(
        child: DefaultButton(
          content: '로그아웃',
          onPressed: () async {
            await TokenStorageService.deleteToken();
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            }
          },
        ),
      ),
    );
  }
}
