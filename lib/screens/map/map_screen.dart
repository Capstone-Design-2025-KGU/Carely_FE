import 'dart:async';
import 'package:carely/screens/user_list.dart';
import 'package:carely/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carely/screens/map/marker_utils.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:carely/screens/map/user_info_card.dart';
import 'package:carely/screens/map/dummy_data.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/screens/map/location_service.dart';
import 'package:carely/screens/map/filter_utilities.dart';

class MapScreen extends StatefulWidget {
  static String id = 'map-screen';
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  String? _selectedMarkerId;
  String? _currentAddress;
  final Set<MemberType> _selectedFilters = {};
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  final double _minChildSize = 0.09;
  final double _maxChildSize = 0.35;
  late DraggableScrollableController _draggableController;
  double _currentSheetSize = 0.09;

  Map<String, BitmapDescriptor> normalMarkerIcons = {};
  Map<String, BitmapDescriptor> selectedMarkerIcons = {};

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

  // LocationService 인스턴스 생성
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _draggableController = DraggableScrollableController();
    _loadMarkerIcons();
    _initializeLocation();

    // DraggableScrollableController 리스너 추가
    _draggableController.addListener(() {
      setState(() {
        _currentSheetSize = _draggableController.size;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _draggableController.dispose();
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
  }

  /// 마커 아이콘 로드
  void _loadMarkerIcons() async {
    try {
      final markerIcons = await MarkerUtils.loadAllMarkerIcons(
        normalSize: 40,
        selectedSize: 50,
      );
      setState(() {
        normalMarkerIcons = markerIcons['normal']!;
        selectedMarkerIcons = markerIcons['selected']!;
      });
      logger.i('마커 아이콘 로드 성공');
    } catch (e) {
      logger.e('마커 아이콘 로드 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 지도
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: dummyUsers[0].location,
              zoom: 14,
            ),
            markers: _getFilteredMarkers(),
            myLocationEnabled: true,
            myLocationButtonEnabled: false, // 별도로 내 위치 버튼을 구현하기 위해 비활성화
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            onTap: (LatLng position) {
              setState(() {
                _selectedMarkerId = null;
              });

              // DraggableScrollableSheet 최소화
              _draggableController.animateTo(
                _minChildSize,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
          ),

          // 상단 검색 바 및 유저 리스트 버튼
          Positioned(
            top: 55,
            right: 16,
            left: 16,
            child: Container(
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
                              onSubmitted: (value) {
                                setState(() {
                                  _searchText = value.trim();
                                });
                                _searchUser(value);
                              },
                            ),
                          ),
                          // 유저 리스트 아이콘 버튼
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: IconButton(
                              icon: Image.asset(
                                'assets/images/user-list.png',
                                width: 24,
                                height: 24,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const UserListScreen(),
                                  ),
                                );
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
          ),

          // 필터링 버튼
          Positioned(
            top: 115,
            left: 18,
            right: 7,
            child: Row(
              children: [
                _buildResetFilterButton(),
                const SizedBox(width: 8),
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

          // 내 위치 버튼 - DraggableScrollableSheet와 함께 움직이도록 설정
          Positioned(
            bottom: _calculateMyLocationButtonPosition(),
            right: 8,
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: IconButton(
                icon: Image.asset(
                  'assets/images/my-location.png',
                  width: 40,
                  height: 40,
                ),
                onPressed: () {
                  if (_currentPosition != null) {
                    _animateCameraToPosition(_currentPosition!);
                  }
                },
              ),
            ),
          ),
          DraggableScrollableSheet(
            controller: _draggableController,
            initialChildSize: _minChildSize,
            minChildSize: _minChildSize,
            maxChildSize: _maxChildSize,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    // 현재 위치 지역명 표시
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 16,
                      ),
                      child: Text(
                        _currentAddress ?? '현재 위치를 불러오는 중...',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 선택된 사용자 정보 카드
                    if (_selectedMarkerId != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: UserInfoCard(userId: _selectedMarkerId!),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // 내 위치 버튼 위치 계산 - DraggableScrollableSheet의 현재 크기에 따라 조정
  double _calculateMyLocationButtonPosition() {
    return MediaQuery.of(context).size.height * _currentSheetSize;
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
        decoration: BoxDecoration(
          color: _selectedFilters.isEmpty ? Colors.grey[400] : Colors.grey[800],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                _selectedFilters.isEmpty
                    ? Colors.grey[400]!
                    : Colors.grey[800]!,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [Icon(Icons.refresh, size: 18, color: Colors.white)],
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

  /// 마커 생성
  Set<Marker> _getFilteredMarkers() {
    Set<Marker> markers = {};
    var filteredUsers = dummyUsers;

    // 검색 필터링
    if (_searchText.isNotEmpty) {
      filteredUsers =
          filteredUsers
              .where(
                (user) =>
                    user.name.toLowerCase().contains(_searchText.toLowerCase()),
              )
              .toList();
    }

    // 유형 필터링
    if (_selectedFilters.isNotEmpty) {
      filteredUsers =
          filteredUsers
              .where(
                (user) => _selectedFilters.contains(
                  _getMemberTypeFromString(user.jobType),
                ),
              )
              .toList();
    }

    for (var user in filteredUsers) {
      bool isSelected = user.id == _selectedMarkerId;

      // 마커 아이콘 가져오기
      BitmapDescriptor icon =
          isSelected
              ? (selectedMarkerIcons[user.jobType] ??
                  BitmapDescriptor.defaultMarker)
              : (normalMarkerIcons[user.jobType] ??
                  BitmapDescriptor.defaultMarker);

      markers.add(
        Marker(
          markerId: MarkerId(
            '${user.id}_${user.name}_${user.location.latitude}',
          ),
          icon: icon,
          position: user.location,
          zIndex: isSelected ? 2 : 1,
          onTap: () {
            setState(() {
              _selectedMarkerId = user.id;
            });

            // DraggableScrollableSheet를 올림
            _draggableController.animateTo(
              _maxChildSize,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );

            _animateCameraToPosition(user.location);
          },
        ),
      );
    }

    // 현재 위치 마커 추가
    if (_currentPosition != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueViolet,
          ),
          position: _currentPosition!,
          infoWindow: const InfoWindow(title: '현재 위치'),
        ),
      );
    }

    return markers;
  }

  // 이름으로 사용자 검색
  void _searchUser(String searchText) {
    if (searchText.isEmpty) {
      setState(() {
        _selectedMarkerId = null;
      });
      return;
    }

    // 검색어와 일치하는 첫 번째 사용자 찾기
    final foundUser =
        dummyUsers
            .where(
              (user) =>
                  user.name.toLowerCase().contains(searchText.toLowerCase()),
            )
            .toList();

    if (foundUser.isNotEmpty) {
      setState(() {
        _selectedMarkerId = foundUser.first.id;
      });

      // 찾은 사용자 위치로 카메라 이동
      _animateCameraToPosition(foundUser.first.location);

      // 정보 패널 확장
      _draggableController.animateTo(
        _maxChildSize,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
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

  /// 카메라 이동 애니메이션
  void _animateCameraToPosition(LatLng position) {
    _mapController?.animateCamera(CameraUpdate.newLatLng(position));
  }
}
