import 'package:flutter/material.dart';
import 'package:carely/screens/map/dummy_data.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/theme/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;
  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isStoryExpanded = false;

  get jobType => null;

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
    final UserData user = dummyUsers.firstWhere((u) => u.id == widget.userId);
    final MemberType? memberType = _getMemberTypeFromString(user.jobType);
    final Color jobSpecificColor = _getDarkerColor(memberType);
    final Color buttonColor = _getButtonColor(memberType);

    final String story =
        user.story ??
        '저희 가족이 어머니를 집에서 모시며 간병을 시작한 지 벌써 3년이 되었습니다. 어머니께서는 67세로, 3년 전 뇌졸중을 겪고 반신 마비가 왔습니다. 그로 인해 왼쪽 팔다리에 불편함이 있으시지만, 꾸준한 재활 치료와 저희 가족의 사랑으로 조금씩 호전되고 계십니다. 어머니와 함께하는 모든 순간이 소중하고, 앞으로도 행복한 추억을 많이 만들고 싶습니다.';
    final List<Map<String, String>> companions =
        user.companions ??
        [
          {'name': '김**', 'date': '2024.10.27', 'msg': '전문적이세요! 너무 너무 감사합니다.'},
          {'name': '박**', 'date': '2024.10.21', 'msg': '따뜻한 마음 감사합니다.'},
          {'name': '이**', 'date': '2024.11.01', 'msg': '덕분에 큰 도움 되었어요.'},
        ];

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
                'assets/images/${user.jobType}/profile_logo.svg',
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
                    story,
                    companions,
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
            bottom: 30,
            child: _buildChatButton(buttonColor),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomContent(
    UserData user,
    MemberType? memberType,
    String story,
    List<Map<String, String>> companions,
    Color buttonColor,
    Color sectionColor,
  ) {
    return Column(
      children: [
        _buildSkillsSection(user, memberType),
        const SizedBox(height: 24),
        _buildStorySection(story, buttonColor),
        const SizedBox(height: 24),
        _buildCompanionsSection(context, companions, sectionColor),
      ],
    );
  }

  Widget _buildTopSection(UserData user, MemberType? memberType) {
    String address = '주소 정보 없음';
    if (user.location.latitude == 37.5865 &&
        user.location.longitude == 126.9980) {
      address = '경기도 용인시 수지구';
    } else if (user.location.latitude == 37.5441 &&
        user.location.longitude == 126.9555) {
      address = '서울시 마포구';
    } else if (user.location.latitude == 37.5878 &&
        user.location.longitude == 126.9974) {
      address = '경기도 성남시 분당구';
    }

    final String badgeLabel;
    final IconData badgeIcon;
    final Color badgeIconColor = _getDarkerColor(memberType);

    if (memberType == MemberType.caregiver) {
      badgeLabel = '인증 요양보호사';
      badgeIcon = Icons.verified;
    } else {
      badgeLabel = 'Carely와 함께한 시간 ${user.togetherTime}';
      badgeIcon = Icons.access_time;
    }

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
                      user.squareProfileImagePath,
                      width: 124,
                      height: 124,
                      fit: BoxFit.cover,
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
                  '나이 ${user.age ?? '정보 없음'}세',
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
                          fontSize: 12,
                          color: AppColors.red300,
                          fontWeight: FontWeight.w600,
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
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
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

  Widget _buildSkillsSection(UserData user, MemberType? memberType) {
    final String title =
        memberType == MemberType.family ? '제가 모시는 분은,' : '제가 할 수 있는 일은,';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.gray800,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 90,
          child: _buildSkillItems(user, _getDarkerColor(memberType)),
        ),
      ],
    );
  }

  Widget _buildSkillItems(UserData user, Color iconColor) {
    List<Widget> skillWidgets = [];
    if (user.skills.isEmpty) {
      return const Text('등록된 스킬이 없습니다.');
    }
    user.skills.forEach((skillKey, skillLevel) {
      String imagePath = 'assets/images/${user.jobType}/skills/$skillKey.png';
      skillWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Image.asset(
                    imagePath,
                    width: 58,
                    height: 58,
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
                skillLevel,
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

    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      alignment: WrapAlignment.center,
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

  Widget _buildCompanionsSection(
    BuildContext context,
    List<Map<String, String>> companions,
    Color cardThemeColor,
  ) {
    // 직업 유형별 배경색 설정
    Color companionCardBackgroundColor = _getCompanionCardBackgroundColor(
      cardThemeColor,
    );
    Color companionCardBorderColor = _getCompanionCardBorderColor(
      cardThemeColor,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '함께한 사람',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.gray800,
            ),
          ),
          const SizedBox(height: 12),
          companions.isEmpty
              ? _buildEmptyCompanionMessage(
                companionCardBackgroundColor,
                companionCardBorderColor,
              )
              : SizedBox(
                height: 124,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: companions.length,
                  itemBuilder: (context, index) {
                    final companion = companions[index];
                    return SizedBox(
                      width: 138,
                      child: Card(
                        color: companionCardBackgroundColor,
                        elevation: 3,
                        shadowColor: Colors.black.withValues(alpha: 0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: companionCardBorderColor,
                            width: 1,
                          ),
                        ),
                        margin: const EdgeInsets.only(right: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    companion['name'] ?? '이름 없음',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.gray800,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    companion['date'] ?? '',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.gray700,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                companion['msg'] ?? '',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.gray800.withValues(
                                    alpha: 0.9,
                                  ),
                                  height: 1.3,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
        ],
      ),
    );
  }

  MemberType? _getMemberTypeFromString(String jobType) {
    switch (jobType) {
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

  // 직업 유형별 함께한 사람 카드 배경색 설정
  Color _getCompanionCardBackgroundColor(Color themeColor) {
    if (themeColor == AppColors.red300) {
      return AppColors.red100; // 가족 배경색
    } else if (themeColor == AppColors.blue300) {
      return AppColors.blue100; // 자원봉사자 배경색
    } else if (themeColor == AppColors.green300) {
      return AppColors.green100; // 요양보호사 배경색
    } else {
      return Color(0xFFFEF0F5); // 기본 배경색
    }
  }

  // 직업 유형별 함께한 사람 카드 테두리 색상 설정
  Color _getCompanionCardBorderColor(Color themeColor) {
    return AppColors.gray100; // 가족 테두리 색상
  }

  // 함께한 사람이 없을 때 표시할 메시지 위젯
  Widget _buildEmptyCompanionMessage(Color backgroundColor, Color borderColor) {
    return Container(
      width: double.infinity,
      height: 124,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          '아직 함께한 사람이 없습니다',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.gray600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
