import 'package:carely/screens/onboarding/type_select_screen.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:carely/widgets/input_text_field.dart';
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
  String _rrnFront = '';
  String _rrnBack = '';

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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InputTextField(
                      label: '이름',
                      hintText: '성함을 입력하세요',
                      onChanged: (value) {},
                    ),
                    InputTextField(
                      label: '전화번호',
                      hintText: '전화번호를 입력하세요',
                      onChanged: (value) {},
                    ),
                    // 주민등록번호 두 필드 추가
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            buildCounter:
                                (
                                  _, {
                                  required currentLength,
                                  required isFocused,
                                  maxLength,
                                }) => null,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: '주민등록번호 앞자리',
                              hintText: 'YYMMDD',
                              labelStyle: TextStyle(
                                color: AppColors.gray500,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                              hintStyle: TextStyle(
                                color: AppColors.gray300,
                                fontSize: 20.0,
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.gray200,
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.gray600,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _rrnFront = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('-', style: TextStyle(fontSize: 18.0)),
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            maxLength: 7,
                            obscureText: true,
                            buildCounter:
                                (
                                  _, {
                                  required currentLength,
                                  required isFocused,
                                  maxLength,
                                }) => null,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: '뒷자리',
                              hintText: '*******',
                              labelStyle: TextStyle(
                                color: AppColors.gray500,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                              hintStyle: TextStyle(
                                color: AppColors.gray300,
                                fontSize: 20.0,
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.gray200,
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.gray600,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _rrnBack = value;
                              });
                              final rrn = _rrnFront + _rrnBack;
                              logger.i('주민등록번호 전체: $rrn');
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            buildCounter:
                                (
                                  _, {
                                  required currentLength,
                                  required isFocused,
                                  maxLength,
                                }) => null,
                            decoration: const InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: '년',
                              hintText: 'YYYY',
                              labelStyle: TextStyle(
                                color: AppColors.gray500,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                              hintStyle: TextStyle(
                                color: AppColors.gray300,
                                fontSize: 20.0,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.gray200,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.gray600,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              // setState(() => _year = value);
                            },
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            buildCounter:
                                (
                                  _, {
                                  required currentLength,
                                  required isFocused,
                                  maxLength,
                                }) => null,
                            decoration: const InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: '월',
                              hintText: 'MM',
                              labelStyle: TextStyle(
                                color: AppColors.gray500,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                              hintStyle: TextStyle(
                                color: AppColors.gray300,
                                fontSize: 20.0,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.gray200,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.gray600,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              // setState(() => _month = value);
                            },
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            buildCounter:
                                (
                                  _, {
                                  required currentLength,
                                  required isFocused,
                                  maxLength,
                                }) => null,
                            decoration: const InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: '일',
                              hintText: 'DD',
                              labelStyle: TextStyle(
                                color: AppColors.gray500,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                              hintStyle: TextStyle(
                                color: AppColors.gray300,
                                fontSize: 20.0,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.gray200,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.gray600,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              // setState(() => _day = value);
                            },
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
