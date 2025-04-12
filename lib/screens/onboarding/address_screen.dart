import 'package:carely/models/address.dart';
import 'package:carely/providers/member_provider.dart';
import 'package:carely/screens/onboarding/skill_screen.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:carely/widgets/input_select_field.dart';
import 'package:carely/widgets/input_text_field.dart';
import 'package:carely/widgets/signup_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:carely/widgets/default_button.dart';
import 'package:kpostal/kpostal.dart';
import 'package:provider/provider.dart';

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
            SignupProgressBar(currentStep: 3, title: '주소를 알려주세요'),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InputSelectField(
                      label: '주소',
                      hintText: '거주지를 입력하세요',
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => KpostalView(
                                  callback: (Kpostal res) {
                                    final fullAddress = res.address; // 도로명 주소
                                    final latitude = res.latitude;
                                    final longitude = res.longitude;

                                    // Provider로 저장
                                    context
                                        .read<MemberProvider>()
                                        .updatePartial(
                                          address: Address(
                                            province: '', // 필요한 경우 분리
                                            city: '',
                                            district: '',
                                            details: '',
                                            latitude: latitude ?? 0.0,
                                            longitude: longitude ?? 0.0,
                                          ),
                                        );

                                    // 상태 갱신용 setState 등도 여기서
                                  },
                                ),
                          ),
                        );
                      },
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
                      builder: (context) => const SkillScreen(),
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
