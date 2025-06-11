import 'package:flutter/material.dart';
import 'package:carely/models/map_member.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/theme/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carely/services/memory_service.dart';
import 'package:carely/models/other_memory.dart';
import 'package:carely/utils/logger_config.dart';

class ProfileScreen extends StatefulWidget {
  final MapMember member;
  const ProfileScreen({super.key, required this.member});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isStoryExpanded = false;
  late Future<List<OtherMemory>> _memoriesFuture;

  @override
  void initState() {
    super.initState();
    logger.i('🔍 ProfileScreen 초기화 - memberId: ${widget.member.memberId}');
    _memoriesFuture = MemoryService.fetchOtherMemories(widget.member.memberId);
  }

  Future<String> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        return [
          p.administrativeArea,
          p.subAdministrativeArea,
          p.locality,
          p.subLocality,
        ].where((e) => e != null && e.isNotEmpty).join(' ');
      }
    } catch (e) {}
    return '주소 정보 없음';
  }

  Color _getDarkerColor(MemberType? memberType) {
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

  String _pathMemberType(MemberType? type) {
    switch (type) {
      case MemberType.family:
        return 'family';
      case MemberType.volunteer:
        return 'volunteer';
      case MemberType.caregiver:
        return 'caregiver';
      default:
        return 'family';
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.member;
    final MemberType memberType = user.memberType;
    final Color jobSpecificColor = _getDarkerColor(memberType);
    final Color buttonColor = _getButtonColor(memberType);

    return Scaffold(
      backgroundColor: jobSpecificColor,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.gray800),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '${_getJobTypeText(memberType)} ${user.name}',
          style: const TextStyle(
            color: AppColors.gray800,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            right: -140,
            bottom: 50,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(12),
              ),
              child: SvgPicture.asset(
                'assets/images/${user.memberType.name}/profile_logo.svg',
                width: 400,
                height: 400,
                fit: BoxFit.contain,
                alignment: Alignment.bottomRight,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTopSection(user, memberType),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: _buildBottomContent(
                    user,
                    memberType,
                    buttonColor,
                    jobSpecificColor,
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildChatButton(buttonColor),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomContent(
    MapMember user,
    MemberType? memberType,
    Color buttonColor,
    Color sectionColor,
  ) {
    final String story =
        user.story ??
        '저희 가족이 어머니를 집에서 모시며 간병을 시작한 지 벌써 3년이 되었습니다. 어머니께서는 67세로, 3년 전 뇌졸중을 겪고 반신 마비가 왔습니다. 그로 인해 왼쪽 팔다리에 불편함이 있으시지만, 꾸준한 재활 치료와 저희 가족의 사랑으로 조금씩 호전되고 계십니다. 어머니와 함께하는 모든 순간이 소중하고, 앞으로도 행복한 추억을 많이 만들고 싶습니다.';
    return Column(
      children: [
        _buildSkillsSection(user, memberType),
        const SizedBox(height: 24),
        _buildStorySection(story, buttonColor),
        const SizedBox(height: 24),
        _buildCompanionsSection(context, sectionColor),
      ],
    );
  }

  Widget _buildTopSection(MapMember user, MemberType? memberType) {
    String address = '주소 정보 없음';
    if (user.address != null) {
      address =
          '${user.address!.province} ${user.address!.city} ${user.address!.district}';
    }

    final String badgeLabel = 'Carely와 함께한 시간 ${user.withTime}';
    final IconData badgeIcon = Icons.access_time;
    final Color badgeIconColor = _getDarkerColor(memberType);

    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 24, left: 24, right: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 124,
            height: 124,
            child: Stack(
              children: [
                // 사각형 프로필 이미지
                Container(
                  width: 124,
                  height: 124,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), // 약간 둥근한 모서리
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SvgPicture.asset(
                      'assets/images/${user.memberType.name}/profile_square/${user.profileImage ?? '1'}.svg',
                      fit: BoxFit.cover,
                      width: 124,
                      height: 124,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.gray800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '나이 ${user.age}세',
                  style: TextStyle(fontSize: 16, color: AppColors.gray700),
                ),
                const SizedBox(height: 2),
                Text(
                  address,
                  style: TextStyle(fontSize: 16, color: AppColors.gray700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(badgeIcon, size: 16, color: AppColors.red300),
                      const SizedBox(width: 6),
                      Text(
                        badgeLabel,
                        style: TextStyle(
                          fontSize: 10.5,
                          color: AppColors.red300,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatButton(Color buttonColor) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 35, top: 15),
      color: Colors.white,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () {
          // TODO: 대화 화면으로 이동
        },
        child: const Text(
          '대화 시작하기',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsSection(MapMember user, MemberType? memberType) {
    final String title =
        memberType == MemberType.family ? '제가 모시는 분은,' : '제가 할 수 있는 일은,';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.gray800,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(height: 90, child: _buildSkillItems(user, memberType)),
        ],
      ),
    );
  }

  Widget _buildSkillItems(MapMember user, MemberType? memberType) {
    List<Widget> skillWidgets = [];
    if (user.skill == null) {
      return const Text('등록된 스킬이 없습니다.');
    }

    final skill = user.skill!;
    final skills = {
      'communication': skill.communication.name,
      'meal': skill.meal.name,
      'toilet': skill.toilet.name,
      'bath': skill.bath.name,
      'walk': skill.walk.name,
    };

    skills.forEach((skillKey, skillLevel) {
      String imagePath =
          'assets/images/${user.memberType.name}/skills/$skillKey.png';
      String displayLevel = '';

      if (memberType == MemberType.family) {
        switch (skillLevel.toLowerCase()) {
          case 'high':
            displayLevel = '준수함';
            break;
          case 'middle':
            displayLevel = '서투름';
            break;
          case 'low':
            displayLevel = '도움 필요함';
            break;
          default:
            displayLevel = skillLevel;
        }
      } else {
        switch (skillLevel.toLowerCase()) {
          case 'high':
            displayLevel = '상급';
            break;
          case 'middle':
            displayLevel = '중급';
            break;
          case 'low':
            displayLevel = '하급';
            break;
          default:
            displayLevel = skillLevel;
        }
      }

      skillWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 52,
                height: 52,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Image.asset(
                    imagePath,
                    width: 52,
                    height: 52,
                    fit: BoxFit.contain,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          padding: const EdgeInsets.all(1.0),
                          child: const Icon(
                            Icons.error_outline,
                            size: 32,
                            color: AppColors.gray800,
                          ),
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                displayLevel,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.gray800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: skillWidgets,
    );
  }

  Widget _buildStorySection(String story, Color buttonColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: const Text(
              '나의 이야기',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.gray800,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            story,
            maxLines: _isStoryExpanded ? null : 3,
            overflow:
                _isStoryExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.gray700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          if (story.length > 100)
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _isStoryExpanded = !_isStoryExpanded;
                  });
                },
                child: Text(
                  _isStoryExpanded ? '접기' : '펼치기',
                  style: TextStyle(
                    color: AppColors.gray300,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCompanionsSection(BuildContext context, Color sectionColor) {
    return FutureBuilder<List<OtherMemory>>(
      future: _memoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('추억을 불러오는 중 오류가 발생했습니다: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('함께한 추억이 없습니다.'));
        }

        final companions = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: const Text(
                '함께한 추억,',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gray800,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: companions.length,
              itemBuilder: (context, index) {
                final memory = companions[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: sectionColor, width: 1.5),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              memory.oppoName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.gray800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              memory.oppoMemo,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.gray600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Color _getButtonColor(MemberType? memberType) {
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

  String _getJobTypeText(MemberType? memberType) {
    switch (memberType) {
      case MemberType.family:
        return '간병인';
      case MemberType.volunteer:
        return '자원봉사자';
      case MemberType.caregiver:
        return '요양보호사';
      default:
        return '';
    }
  }
}
