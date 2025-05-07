import 'package:flutter/material.dart';
import 'package:carely/screens/map/user_info_card.dart';
import 'package:carely/screens/map/dummy_data.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/screens/map/filter_utilities.dart';
import 'package:carely/screens/map/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserListScreen extends StatefulWidget {
  static String id = 'user-list-screen';
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  final Set<MemberType> _selectedFilters = {};
  String? _currentAddress;
  final LocationService _locationService = LocationService();

  // 필터 버튼 색상 정의
  final Map<MemberType, Color> filterColors = {
    MemberType.family: AppColors.red300,
    MemberType.volunteer: AppColors.blue300,
    MemberType.caregiver: AppColors.green300,
  };

  // 필터 버튼 비활성화 색상 정의
  final Map<MemberType, Color> filterInactiveColors = {
    MemberType.family: AppColors.red100,
    MemberType.volunteer: AppColors.blue100,
    MemberType.caregiver: AppColors.green100,
  };

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// 위치 서비스 초기화
  void _initializeLocation() async {
    await _locationService.initialize();
    _locationService.onLocationChanged((newPosition, address) {
      setState(() {
        _currentAddress = address;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // 검색어와 필터를 적용한 사용자 목록
    List<UserData> filteredUsers = FilterUtils.applyFilters(
      items: dummyUsers,
      searchText: _searchText,
      typeFilters: _selectedFilters,
      nameSelector: (user) => user.name,
      typeSelector: (user) => FilterUtils.getMemberTypeFromString(user.jobType),
    );

    return Scaffold(
      body: Column(
        children: [
          // 상단 검색 바 및 맵 버튼
          Container(
            padding: const EdgeInsets.only(
              top: 55,
              left: 16,
              right: 16,
              bottom: 10,
            ),
            color: Colors.white,
            child: Row(
              children: [
                // 검색 바
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText: '이웃을 검색해 보세요.',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _searchText = value.trim();
                              });
                            },
                          ),
                        ),
                        // 맵 화면으로 이동하는 아이콘 버튼
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: IconButton(
                            icon: Image.asset(
                              'assets/images/map-trifold.png',
                              width: 24,
                              height: 24,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 필터링 버튼
          Container(
            padding: const EdgeInsets.only(
              top: 0,
              left: 18,
              right: 7,
              bottom: 10,
            ),
            color: Colors.white,
            child: Row(
              children: [
                // 필터 리셋 버튼 (항상 표시)
                _buildResetFilterButton(),
                const SizedBox(width: 8),
                // 간병인 필터
                _buildFilterChip(
                  label: '간병인',
                  isSelected: _selectedFilters.contains(MemberType.family),
                  memberType: MemberType.family,
                  onTap: () {
                    setState(() {
                      FilterUtils.toggleFilter(
                        _selectedFilters,
                        MemberType.family,
                      );
                    });
                  },
                ),
                const SizedBox(width: 8),
                // 자원봉사자 필터
                _buildFilterChip(
                  label: '자원봉사자',
                  isSelected: _selectedFilters.contains(MemberType.volunteer),
                  memberType: MemberType.volunteer,
                  onTap: () {
                    setState(() {
                      FilterUtils.toggleFilter(
                        _selectedFilters,
                        MemberType.volunteer,
                      );
                    });
                  },
                ),
                const SizedBox(width: 8),
                // 요양보호사 필터
                _buildFilterChip(
                  label: '요양보호사',
                  isSelected: _selectedFilters.contains(MemberType.caregiver),
                  memberType: MemberType.caregiver,
                  onTap: () {
                    setState(() {
                      FilterUtils.toggleFilter(
                        _selectedFilters,
                        MemberType.caregiver,
                      );
                    });
                  },
                ),
              ],
            ),
          ),

          // 위치 정보 헤더
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            alignment: Alignment.centerLeft,
            child: Text(
              _currentAddress ?? '현재 위치를 불러오는 중...',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),

          // 사용자 목록
          Expanded(
            child:
                filteredUsers.isEmpty
                    ? Center(
                      child: Text(
                        '검색 결과가 없습니다.',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        return UserInfoCard(userId: filteredUsers[index].id);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  // 필터 리셋 버튼
  Widget _buildResetFilterButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilters.clear();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/reset.png', width: 32, height: 32),
          ],
        ),
      ),
    );
  }

  // 필터 칩 위젯
  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required MemberType memberType,
    VoidCallback? onTap,
    IconData? icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? filterColors[memberType]
                  : filterInactiveColors[memberType],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : filterColors[memberType]!,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : filterColors[memberType],
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            if (icon != null) Icon(icon, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}
