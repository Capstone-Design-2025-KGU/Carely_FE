import 'package:carely/models/address.dart';
import 'package:carely/providers/member_provider.dart';
import 'package:carely/screens/onboarding/skill_screen.dart';
import 'package:carely/utils/logger_config.dart';
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
  String _selectedAddressText = '';

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
                      displayText: _selectedAddressText,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => KpostalView(
                                  callback: (Kpostal result) {
                                    final parts = result.address.split(' ');
                                    final province =
                                        parts.isNotEmpty ? parts[0] : '';
                                    final city =
                                        parts.length > 1 ? parts[1] : '';
                                    final district =
                                        parts.length > 2 ? parts[2] : '';

                                    context
                                        .read<MemberProvider>()
                                        .updatePartial(
                                          address: Address(
                                            province: province,
                                            city: city,
                                            district: district,
                                            details: '',
                                            latitude: result.latitude ?? 0.0,
                                            longitude: result.longitude ?? 0.0,
                                          ),
                                        );

                                    setState(() {
                                      _selectedAddressText =
                                          '$province $city $district';
                                    });
                                  },
                                ),
                          ),
                        );
                      },
                    ),
                    InputTextField(
                      label: '상세 주소',
                      hintText: '상세 주소를 적어주세요',
                      onChanged: (value) {
                        final provider = context.read<MemberProvider>();
                        final member = provider.member;

                        if (member?.address != null) {
                          provider.updatePartial(
                            address: member!.address!.copyWith(details: value),
                          );
                        }
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
                onPressed: () {
                  logger.i(
                    '📍 주소 정보: ${context.read<MemberProvider>().member?.address}',
                  );
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
