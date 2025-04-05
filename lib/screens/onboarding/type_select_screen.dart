import 'package:carely/theme/colors.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:carely/widgets/default_button.dart';
import 'package:carely/widgets/signup_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TypeSelectScreen extends StatefulWidget {
  const TypeSelectScreen({super.key});

  @override
  State<TypeSelectScreen> createState() => _TypeSelectScreenState();
}

class _TypeSelectScreenState extends State<TypeSelectScreen> {
  String? selectedType;

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
              currentStep: 2,
              totalSteps: 4,
              title: '본인을 선택하세요',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MemberTypeCard(
                      title: '간병인',
                      memberType: 'family',
                      assetPath: 'assets/images/family/type.svg',
                      isSelected: selectedType == 'family',
                      onTap: () => setState(() => selectedType = 'family'),
                    ),
                    MemberTypeCard(
                      title: '자원봉사자',
                      memberType: 'volunteer',
                      assetPath: 'assets/images/volunteer/type.svg',
                      isSelected: selectedType == 'volunteer',
                      onTap: () => setState(() => selectedType = 'volunteer'),
                    ),
                    MemberTypeCard(
                      title: '요양보호사',
                      memberType: 'caregiver',
                      assetPath: 'assets/images/caregiver/type.svg',
                      isSelected: selectedType == 'caregiver',
                      onTap: () => setState(() => selectedType = 'caregiver'),
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
                isEnable: selectedType != null,
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

class MemberTypeCard extends StatelessWidget {
  final String title;
  final String memberType; // "family", "volunteer", "caregiver"
  final String assetPath;
  final bool isSelected;
  final VoidCallback onTap;

  const MemberTypeCard({
    super.key,
    required this.title,
    required this.memberType,
    required this.assetPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Container(
          width: ScreenSize.width(context, 336.0),
          height: ScreenSize.height(context, 88.0),
          decoration: BoxDecoration(
            color: isSelected ? _getSelectedColor(memberType) : Colors.white,
            boxShadow: [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 4.0),
            ],
            border: Border.all(
              color:
                  isSelected
                      ? _getSelectedHighlightColor(memberType)
                      : Colors.transparent,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SvgPicture.asset(assetPath, width: 64.0, height: 64.0),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getSelectedColor(String memberType) {
    switch (memberType) {
      case 'family':
        return AppColors.main50;
      case 'volunteer':
        return AppColors.blue100;
      case 'caregiver':
        return AppColors.green100;
      default:
        return Colors.white;
    }
  }

  Color _getSelectedHighlightColor(String memberType) {
    switch (memberType) {
      case 'family':
        return AppColors.mainPrimary;
      case 'volunteer':
        return AppColors.blue300;
      case 'caregiver':
        return AppColors.green300;
      default:
        return Colors.white;
    }
  }
}
