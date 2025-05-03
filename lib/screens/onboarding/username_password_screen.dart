import 'package:carely/providers/member_provider.dart';
import 'package:carely/screens/onboarding/type_select_screen.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:carely/widgets/default_button.dart';
import 'package:carely/widgets/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsernamePasswordScreen extends StatefulWidget {
  static String id = 'username-password-screen';
  const UsernamePasswordScreen({super.key});

  @override
  State<UsernamePasswordScreen> createState() => _UsernamePasswordScreenState();
}

class _UsernamePasswordScreenState extends State<UsernamePasswordScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool get isFilled =>
      _usernameController.text.trim().isNotEmpty &&
      _passwordController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(title: '회원가입'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 40.0),
            InputTextField(
              label: '아이디',
              hintText: '아이디를 입력하세요',
              controller: _usernameController,
              onChanged: (_) => setState(() {}),
            ),
            InputTextField(
              label: '비밀번호',
              hintText: '비밀번호를 입력하세요',
              controller: _passwordController,
              onChanged: (_) => setState(() {}),
            ),
            const Spacer(),
            DefaultButton(
              content: '다음',
              isEnable: isFilled,
              onPressed: () {
                context.read<MemberProvider>().updatePartial(
                  username: _usernameController.text.trim(),
                  password: _passwordController.text.trim(),
                );
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const TypeSelectScreen()),
                );
              },
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
