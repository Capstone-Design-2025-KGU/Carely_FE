import 'package:flutter/material.dart';
import 'package:carely/screens/map/user_info_card.dart';
import 'package:carely/screens/map/dummy_data.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/screens/map/filter_utilities.dart';
import 'package:carely/screens/map/location_service.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:carely/utils/logger_config.dart';

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
  LatLng? _currentPosition;
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
        _currentPosition = newPosition;
        _currentAddress = address;
      });
    });

    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    try {
      // 먼저 마지막으로 저장된 위치 정보가 있는지 확인
      if (_locationService.lastKnownAddress != null) {
        setState(() {
          _currentPosition = _locationService.lastKnownPosition;
          _currentAddress = _locationService.lastKnownAddress;
        });
        logger.i('저장된 위치 정보 사용: ${_locationService.lastKnownAddress}');
        return;
      }
      
      setState(() {
        _currentAddress = '현재 위치를 불러오는 중...';
      });

      bool serviceEnabled =
          await _locationService.locationController.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled =
            await _locationService.locationController.requestService();
        if (!serviceEnabled) {
          setState(() {
            _currentAddress = '위치 서비스가 비활성화되어 있습니다.';
          });
          return;
        }
      }

      // 위치 권한 확인
      var permissionGranted =
          await _locationService.locationController.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted =
            await _locationService.locationController.requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) {
          setState(() {
            _currentAddress = '위치 권한이 없습니다.';
          });
          return;
        }
      }

      // 위치 정보 가져오기
      final locationData =
          await _locationService.locationController.getLocation();
      if (locationData.latitude != null && locationData.longitude != null) {
        LatLng position = LatLng(
          locationData.latitude!,
          locationData.longitude!,
        );

        // 주소 변환
        String? address = await _locationService.getAddressFromLatLng(position);

        // 디버그 로그
        logger.i('현재 위치: $position, 주소: $address');

        setState(() {
          _currentPosition = position;
          _currentAddress = address ?? '주소를 찾을 수 없습니다.';
        });
      } else {
        setState(() {
          _currentAddress = '위치 정보를 가져올 수 없습니다.';
        });
      }
    } catch (e) {
      logger.e('위치 정보 가져오기 오류: $e');
      setState(() {
        _currentAddress = '위치 정보를 가져오는 중 오류가 발생했습니다.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            icon: SvgPicture.asset(
                              'assets/images/map-trifold.svg',
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
            child: Row(
              children: [
                Text(
                  _currentAddress ?? '현재 위치를 불러오는 중...',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),

                Container(
                  margin: const EdgeInsets.only(left: 8),
                  width: 16,
                  height: 16,
                ),
                const Spacer(),
              ],
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
            SvgPicture.asset('assets/images/reset.svg', width: 32, height: 32),
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
