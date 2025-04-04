import 'package:carely/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:carely/screens/map/dummy_data.dart';
import 'package:carely/utils/member_type.dart';

class UserInfoCard extends StatelessWidget {
  final String userId;
  final double? width;

  const UserInfoCard({super.key, required this.userId, this.width});

  @override
  Widget build(BuildContext context) {
    final UserData userData = dummyUsers.firstWhere(
      (user) => user.id == userId,
    );

    // 직업 유형별 배경색 설정
    Color backgroundColor = _getBackgroundColor(userData.jobType);

    return Container(
      width: width ?? double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      child: Column(
        mainAxisSize: MainAxisSize.min, // 높이를 내용에 맞게 자동 조정
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(userData.profileImagePath),
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
                    const SizedBox(height: 5),

                    // 배지 표시
                    Row(children: [_buildJobBadge(userData)]),
                  ],
                ),
              ),

              // 거리 표시
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

          // 스킬 아이콘을 `Wrap`으로 변경하여 Overflow 방지
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: _buildSkillIcons(userData),
          ),
        ],
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
          _buildSkillIcon(
            skillKey,
            userData.skills[skillKey]!,
            userData.jobType,
          ),
        );
      }
    }

    return skillWidgets;
  }

  /// 스킬 아이콘 UI
  Widget _buildSkillIcon(String skillKey, String skillLevel, String jobType) {
    String imagePath = 'assets/images/$jobType/skills/$skillKey.png';

    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Center(child: Image.asset(imagePath, width: 52, height: 52)),
        ),
        const SizedBox(height: 5),
        Text(
          skillLevel,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _getColorForJobType(jobType),
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
