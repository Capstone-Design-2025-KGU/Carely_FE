import 'package:carely/theme/colors.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:carely/widgets/default_app_bar.dart';
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '약관에 먼저 동의해 주세요',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray800,
                      ),
                    ),
                    SizedBox(height: 36.0),
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
          ),
        ],
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
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4.0)],
            border: Border.all(
              color:
                  isSelected
                      ? _getSelectedHighlightColor(memberType)
                      : Colors.transparent,
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(assetPath, width: 64.0, height: 64.0),
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
