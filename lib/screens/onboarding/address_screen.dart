import 'package:carely/screens/onboarding/type_select_screen.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:carely/widgets/input_select_field.dart';
import 'package:carely/widgets/input_text_field.dart';
import 'package:carely/widgets/signup_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:carely/widgets/default_button.dart';

class AddressScreen extends StatefulWidget {
  static String id = 'address-screen';
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
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
              currentStep: 4,
              totalSteps: 6,
              title: '주소를 알려주세요',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InputSelectField(
                      label: '주소',
                      displayText: '거주지를 입력하세요',
                      onTap: () {},
                    ),
                    InputTextField(
                      label: '상세 주소',
                      hintText: '상세 주소를 적어주세요',
                      onChanged: (value) {},
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
