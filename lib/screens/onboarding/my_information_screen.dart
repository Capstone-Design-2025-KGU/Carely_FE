import 'package:carely/screens/onboarding/type_select_screen.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:carely/widgets/signup_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:carely/widgets/default_button.dart';

class MyInformationScreen extends StatefulWidget {
  static String id = 'my-information-screen';
  const MyInformationScreen({super.key});

  @override
  State<MyInformationScreen> createState() => _MyInformationScreenState();
}

class _MyInformationScreenState extends State<MyInformationScreen> {
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
              currentStep: 3,
              totalSteps: 4,
              title: '내 정보를 적어주세요',
            ),
            Expanded(child: SingleChildScrollView(child: Column(children: []))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: DefaultButton(
                content: '다음',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TypeSelectScreen(),
                    ),
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
