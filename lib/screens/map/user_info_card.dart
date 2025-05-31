import 'package:carely/theme/colors.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:flutter/material.dart';
import 'package:carely/screens/map/dummy_data.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/screens/profile_screen.dart';
import 'package:flutter_svg/svg.dart';

class UserInfoCard extends StatelessWidget {
  final String userId;
  final double? width;

  UserInfoCard({super.key, required this.userId, this.width});

  @override
  Widget build(BuildContext context) {
    final UserData userData = dummyUsers.firstWhere(
      (user) => user.id == userId,
    );

    // 직업 유형별 배경색 설정
    Color backgroundColor = _getBackgroundColor(userData.jobType);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProfileScreen(userId: userId)),
        );
      },
      child: Container(
        width: width ?? double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -15,
              bottom: -40,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(12),
                ),
                child: SvgPicture.asset(
                  'assets/images/${userData.jobType}/profile_logo.svg',
                  width: 132,
                  height: 132,
                  alignment: Alignment.bottomRight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: SvgPicture.asset(
                            userData.profileImagePath,
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // 이름 및 정보
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_getJobTypeText(userData.jobType)} ${userData.name}님',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 7),

                            // 배지 표시
                            Row(children: [_buildJobBadge(userData)]),
                          ],
                        ),
                      ),
                      Text(
                        '${userData.distance}km',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.gray300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _buildSkillIcons(userData),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 직업 유형별 배경색 설정
  Color _getBackgroundColor(String jobType) {
    MemberType? memberType = _getMemberTypeFromString(jobType);
    switch (memberType) {
      case MemberType.family:
        return AppColors.red100;
      case MemberType.volunteer:
        return AppColors.blue100;
      case MemberType.caregiver:
        return AppColors.green100;
      default:
        return Colors.white;
    }
  }

  /// 배지 UI 생성
  Widget _buildJobBadge(UserData userData) {
    String label;
    Color badgeColor;
    Color textColor;
    IconData icon;

    MemberType? memberType = _getMemberTypeFromString(userData.jobType);
    if (memberType == MemberType.caregiver) {
      label = '인증 요양보호사';
      badgeColor = Colors.white;
      textColor = AppColors.mainPrimary;
      icon = Icons.medical_services;
    } else {
      label = '함께한 시간: ${userData.togetherTime}';
      badgeColor = Colors.white;
      textColor = AppColors.mainPrimary;
      icon = Icons.access_time;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// 스킬 아이콘 리스트 생성
  List<Widget> _buildSkillIcons(UserData userData) {
    List<Widget> skillWidgets = [];
    List<String> skillKeys = [
      'communication',
      'meal',
      'toilet',
      'bath',
      'walk',
    ];

    for (var skillKey in skillKeys) {
      if (userData.skills.containsKey(skillKey)) {
        skillWidgets.add(
          _buildSkillIcon(skillKey, userData.skills[skillKey]!, userData),
        );
      }
    }

    return skillWidgets;
  }

  final Map<String, Map<String, String>> _skillAssetPaths = {
    'caregiver': {
      'communication': 'assets/images/caregiver/skills/communication.png',
      'meal': 'assets/images/caregiver/skills/meal.png',
      'toilet': 'assets/images/caregiver/skills/toilet.png',
      'bath': 'assets/images/caregiver/skills/bath.png',
      'walk': 'assets/images/caregiver/skills/walk.png',
    },
    'family': {
      'communication': 'assets/images/family/skills/communication.png',
      'meal': 'assets/images/family/skills/meal.png',
      'toilet': 'assets/images/family/skills/toilet.png',
      'bath': 'assets/images/family/skills/bath.png',
      'walk': 'assets/images/family/skills/walk.png',
    },
    'volunteer': {
      'communication': 'assets/images/volunteer/skills/communication.png',
      'meal': 'assets/images/volunteer/skills/meal.png',
      'toilet': 'assets/images/volunteer/skills/toilet.png',
      'bath': 'assets/images/volunteer/skills/bath.png',
      'walk': 'assets/images/volunteer/skills/walk.png',
    },
  };

  /// 스킬 아이콘 UI
  Widget _buildSkillIcon(
    String skillKey,
    String skillLevel,
    UserData userData,
  ) {
    String imagePath = userData.getSkillImagePath(skillKey);
    logger.i(
      'Attempting to load skill icon for ${userData.jobType} - $skillKey from: $imagePath',
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.gray25.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: Image.asset(
              imagePath,
              width: 44,
              height: 44,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                logger.e('스킬 아이콘 로드 오류: $imagePath - $error');
                return const Icon(
                  Icons.error_outline,
                  size: 28,
                  color: AppColors.gray800,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          skillLevel,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.gray800,
          ),
        ),
      ],
    );
  }

  /// 직업 유형별 색상 반환
  Color _getColorForJobType(String jobType) {
    MemberType? memberType = _getMemberTypeFromString(jobType);
    switch (memberType) {
      case MemberType.family:
        return AppColors.red300;
      case MemberType.volunteer:
        return AppColors.blue300;
      case MemberType.caregiver:
        return AppColors.green300;
      default:
        return AppColors.gray300;
    }
  }

  /// 직업 유형 텍스트 변환
  String _getJobTypeText(String jobType) {
    MemberType? memberType = _getMemberTypeFromString(jobType);
    switch (memberType) {
      case MemberType.family:
        return '간병인';
      case MemberType.volunteer:
        return '자원봉사자';
      case MemberType.caregiver:
        return '요양보호사';
      default:
        return jobType;
    }
  }

  // String을 MemberType으로 변환하는 함수
  MemberType? _getMemberTypeFromString(String typeString) {
    switch (typeString) {
      case 'family':
        return MemberType.family;
      case 'volunteer':
        return MemberType.volunteer;
      case 'caregiver':
        return MemberType.caregiver;
      default:
        return null;
    }
  }
}
