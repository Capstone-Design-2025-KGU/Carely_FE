import 'package:carely/screens/onboarding/story_screen.dart';
import 'package:carely/screens/onboarding/type_select_screen.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:carely/widgets/input_select_field.dart';
import 'package:carely/widgets/signup_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:carely/widgets/default_button.dart';

class SkillScreen extends StatefulWidget {
  static String id = 'skill-screen';
  const SkillScreen({super.key});

  @override
  State<SkillScreen> createState() => _SkillScreenState();
}

class _SkillScreenState extends State<SkillScreen> {
  final Map<String, int> _selectedLevels = {
    '대화': -1,
    '식사': -1,
    '화장실': -1,
    '목욕': -1,
    '걷기': -1,
  };

  String _getDisplayText(String label) {
    final index = _selectedLevels[label];
    if (index == null || index == -1) return '선택해주세요';
    return ['수월', '보통', '서투름'][index];
  }

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
              title: '모시는 분에 대해 알려주세요',
              //TODO : 추후 앞서 선택한 유저 타입에 맞게 타이틀 바꾸도록 수정
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InputSelectFieldWithIcon(
                      imagePath:
                          'assets/images/family/skills/communication.png',
                      label: '대화',
                      displayText:
                          _selectedLevels['대화'] == -1
                              ? ''
                              : _getDisplayText('대화'),
                      onTap: () async {
                        await showSkillSelectModal(
                          context: context,
                          label: '대화',
                          selectedIndex: _selectedLevels['대화'] ?? -1,
                          onSelect: (newIndex) {
                            setState(() {
                              _selectedLevels['대화'] = newIndex;
                            });
                          },
                        );
                      },
                    ),
                    InputSelectFieldWithIcon(
                      imagePath: 'assets/images/family/skills/meal.png',
                      label: '식사',
                      displayText:
                          _selectedLevels['식사'] == -1
                              ? ''
                              : _getDisplayText('식사'),
                      onTap: () async {
                        await showSkillSelectModal(
                          context: context,
                          label: '식사',
                          selectedIndex: _selectedLevels['식사'] ?? -1,
                          onSelect: (newIndex) {
                            setState(() {
                              _selectedLevels['식사'] = newIndex;
                            });
                          },
                        );
                      },
                    ),
                    InputSelectFieldWithIcon(
                      imagePath: 'assets/images/family/skills/toilet.png',
                      label: '화장실',
                      displayText:
                          _selectedLevels['화장실'] == -1
                              ? ''
                              : _getDisplayText('화장실'),
                      onTap: () async {
                        await showSkillSelectModal(
                          context: context,
                          label: '화장실',
                          selectedIndex: _selectedLevels['화장실'] ?? -1,
                          onSelect: (newIndex) {
                            setState(() {
                              _selectedLevels['화장실'] = newIndex;
                            });
                          },
                        );
                      },
                    ),
                    InputSelectFieldWithIcon(
                      imagePath: 'assets/images/family/skills/bath.png',
                      label: '목욕',
                      displayText:
                          _selectedLevels['목욕'] == -1
                              ? ''
                              : _getDisplayText('목욕'),
                      onTap: () async {
                        await showSkillSelectModal(
                          context: context,
                          label: '목욕',
                          selectedIndex: _selectedLevels['목욕'] ?? -1,
                          onSelect: (newIndex) {
                            setState(() {
                              _selectedLevels['목욕'] = newIndex;
                            });
                          },
                        );
                      },
                    ),
                    InputSelectFieldWithIcon(
                      imagePath: 'assets/images/family/skills/walk.png',
                      label: '걷기',
                      displayText:
                          _selectedLevels['걷기'] == -1
                              ? ''
                              : _getDisplayText('걷기'),
                      onTap: () async {
                        await showSkillSelectModal(
                          context: context,
                          label: '걷기',
                          selectedIndex: _selectedLevels['걷기'] ?? -1,
                          onSelect: (newIndex) {
                            setState(() {
                              _selectedLevels['걷기'] = newIndex;
                            });
                          },
                        );
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const StoryScreen(),
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

class InputSelectFieldWithIcon extends StatelessWidget {
  final String imagePath;
  final String label;
  final String displayText;
  final VoidCallback onTap;

  const InputSelectFieldWithIcon({
    super.key,
    required this.imagePath,
    required this.label,
    required this.displayText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: CircleAvatar(
            radius: 28.0,
            backgroundColor: AppColors.gray25,
            child: Image.asset(imagePath, width: 72.0, height: 72.0),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: InputSelectField(
            label: label,
            displayText: displayText,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}

class _SelectableOption extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _SelectableOption({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: isSelected ? AppColors.mainPrimary : AppColors.gray300,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: AppColors.gray800,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showSkillSelectModal({
  required BuildContext context,
  required String label,
  required int selectedIndex,
  required void Function(int) onSelect,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (_) {
      int localSelected = selectedIndex;

      return StatefulBuilder(
        builder: (context, setModalState) {
          return SizedBox(
            width: ScreenSize.width(context, 354.0),
            height: ScreenSize.height(context, 276.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.gray800,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 28.0),
                  ...List.generate(3, (i) {
                    final levels = ['수월', '보통', '서투름'];
                    return GestureDetector(
                      onTap: () {
                        setModalState(() => localSelected = i);
                        onSelect(i); // 부모에 반영
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check,
                              color:
                                  i == localSelected
                                      ? AppColors.mainPrimary
                                      : AppColors.gray300,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              levels[i],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.gray800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const Spacer(),
                  DefaultButton(
                    content: '확인',
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
