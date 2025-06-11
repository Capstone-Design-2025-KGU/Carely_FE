import 'package:flutter/material.dart';
import 'package:carely/screens/profile_screen.dart';
import 'package:carely/services/map/map_services.dart';
import 'package:carely/models/map_member.dart';
import 'package:carely/models/neighbor_member.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/utils/member_color.dart';
import 'package:carely/theme/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carely/utils/logger_config.dart';

class UserInfoCard extends StatelessWidget {
  final int memberId;
  final double? width;
  final NeighborMember? neighborData;

  const UserInfoCard({
    super.key,
    required this.memberId,
    this.width,
    this.neighborData,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MapMember?>(
      future: MapServices.fetchMemberDetail(memberId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: width ?? double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          logger.e(
            '❌ UserInfoCard 에러 - memberId: $memberId, 에러: ${snapshot.error}',
          );
          return Container(
            width: width ?? double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(child: Text('사용자 정보를 불러올 수 없습니다.')),
          );
        }

        if (!snapshot.hasData) {
          logger.w('⚠️ UserInfoCard 데이터 없음 - memberId: $memberId');
          return Container(
            width: width ?? double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(child: Text('사용자 정보를 불러올 수 없습니다.')),
          );
        }

        final userData = snapshot.data!;
        Color backgroundColor = getBackgroundColor(userData.memberType);

        final distance = neighborData?.distance ?? userData.distance;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfileScreen(member: userData),
              ),
            );
          },
          child: Container(
            width: 332,
            height: 172,
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
                      'assets/images/${userData.memberType.name}/profile_logo.svg',
                      width: 132,
                      height: 132,
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 90,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: SvgPicture.asset(
                                  'assets/images/${userData.memberType.name}/profile/${userData.profileImage ?? '1'}.svg',
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${_getMemberTypeDisplayName(userData.memberType)} ${userData.name}님',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  _buildTimeTogetherBadge(userData.withTime),
                                ],
                              ),
                            ),
                            Text(
                              '${distance.toStringAsFixed(1)}km',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.gray300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: _buildSkillItems(
                            userData,
                            userData.memberType,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// MemberType을 한글 이름으로 변환
  String _getMemberTypeDisplayName(MemberType memberType) {
    switch (memberType) {
      case MemberType.family:
        return '간병인';
      case MemberType.volunteer:
        return '자원봉사자';
      case MemberType.caregiver:
        return '요양보호사';
    }
  }

  /// 직업 유형별 배지 생성
  Widget _buildTimeTogetherBadge(int withTime) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.access_time, size: 12, color: AppColors.red300),
          const SizedBox(width: 3),
          Text(
            '함께한 $withTime시간',
            style: TextStyle(
              color: AppColors.red300,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// 스킬 아이콘 생성
  List<Widget> _buildSkillItems(MapMember userData, MemberType memberType) {
    if (userData.skill == null) {
      return [const Text('스킬 정보 없음', style: TextStyle(fontSize: 12))];
    }

    final skill = userData.skill!;
    return [
      _buildSkillItem('communication', skill.communication.name, memberType),
      _buildSkillItem('meal', skill.meal.name, memberType),
      _buildSkillItem('toilet', skill.toilet.name, memberType),
      _buildSkillItem('bath', skill.bath.name, memberType),
      _buildSkillItem('walk', skill.walk.name, memberType),
    ];
  }

  /// 개별 스킬 아이콘 생성
  Widget _buildSkillItem(
    String skillName,
    String skillLevel,
    MemberType memberType,
  ) {
    String displayLevelText;
    if (memberType == MemberType.family) {
      switch (skillLevel.toLowerCase()) {
        case 'high':
          displayLevelText = '준수함';
          break;
        case 'middle':
          displayLevelText = '서투름';
          break;
        case 'low':
          displayLevelText = '도움 필요함';
          break;
        default:
          displayLevelText = '정보 없음';
      }
    } else {
      switch (skillLevel.toLowerCase()) {
        case 'high':
          displayLevelText = '상급';
          break;
        case 'middle':
          displayLevelText = '중급';
          break;
        case 'low':
          displayLevelText = '하급';
          break;
        default:
          displayLevelText = '정보 없음';
      }
    }

    String imagePath = 'assets/images/${memberType.name}/skills/$skillName.png';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Center(child: Image.asset(imagePath, width: 40, height: 40)),
        ),
        const SizedBox(height: 1),
        Text(
          displayLevelText,
          style: TextStyle(fontSize: 9, color: AppColors.gray800),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
