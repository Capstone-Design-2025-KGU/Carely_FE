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
import 'package:carely/screens/map/clustering/cluster_item.dart';
import 'package:carely/screens/map/clustering/cluster_manager.dart'
    as mycluster;
import 'package:carely/screens/map/clustering/cluster_helper.dart';
import 'package:carely/screens/map/clustering/custom_cluster_icon.dart';
import 'package:carely/screens/map/clustering/cluster_circle_offset.dart';
import 'package:carely/screens/map/clustering/avoid_cluster_overlap.dart';
import 'dart:math';

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
  double _currentZoom = 14.5;
  List<ClusterItem> _allClusterItems = [];
  List<ClusterItem> _selectedClusterItems = [];

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
    _allClusterItems =
        dummyUsers.map((user) {
          JobType jobType;
          switch (user.jobType) {
            case 'family':
              jobType = JobType.family;
              break;
            case 'volunteer':
              jobType = JobType.volunteer;
              break;
            case 'caregiver':
              jobType = JobType.caregiver;
              break;
            default:
              jobType = JobType.family;
          }
          return ClusterItem(
            id: user.id,
            position: user.location,
            jobType: jobType,
            data: {'user': user},
          );
        }).toList();

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
          FutureBuilder<Set<Marker>>(
            future: _buildMarkersWithClusterIcons(),
            builder: (context, snapshot) {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: dummyUsers[0].location,
                  zoom: 14.5,
                ),
                markers: snapshot.data ?? {},
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
                onCameraMove: (CameraPosition pos) {
                  setState(() {
                    _currentZoom = pos.zoom;
                  });
                },
                onTap: (LatLng position) {
                  setState(() {
                    _selectedClusterItems = [];
                    _selectedMarkerId = null;
                  });
                  _draggableController.animateTo(
                    _minChildSize,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
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
                      padding: const EdgeInsets.only(
                        top: 4,
                        left: 24,
                        right: 16,
                        bottom: 4,
                      ),
                      child: Text(
                        _currentAddress ?? '현재 위치를 불러오는 중...',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 선택된 클러스터 내 사용자 정보 카드들
                    if (_selectedClusterItems.isNotEmpty)
                      ..._selectedClusterItems.map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: UserInfoCard(userId: item.id),
                        ),
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

  Future<Set<Marker>> _buildMarkersWithClusterIcons() async {
    Set<Marker> markers = {};
    List<ClusterItem> filtered =
        _allClusterItems.where((item) {
          if (_searchText.isNotEmpty) {
            final user = item.data['user'];
            if (user == null ||
                !(user.name.toLowerCase().contains(
                  _searchText.toLowerCase(),
                ))) {
              return false;
            }
          }
          if (_selectedFilters.isNotEmpty) {
            final user = item.data['user'];
            if (user == null) return false;
            JobType jobType = item.jobType;
            if (!_selectedFilters.contains(_getMemberTypeFromJobType(jobType)))
              return false;
          }
          return true;
        }).toList();

    if (_currentZoom <= 14.2) {
      final bounds = await _mapController?.getVisibleRegion();
      if (bounds != null) {
        final diag = ClusterHelper.distance(bounds.southwest, bounds.northeast);
        final clusterRadius = diag / 8;
        // 1. 직업별로 분리하여 각각 클러스터링 및 겹침 해소
        Map<JobType, List<ClusterWithRadius>> clustersByType = {};
        for (var type in JobType.values) {
          final itemsOfType = filtered.where((e) => e.jobType == type).toList();
          final clusters = ClusterHelper.cluster(itemsOfType, clusterRadius);
          clustersByType[type] = avoidClusterOverlap(clusters);
        }
        // 2. 전체 클러스터의 평균 중심점(지도 중심) 계산
        List<LatLng> allCenters = [];
        clustersByType.values
            .expand((list) => list)
            .forEach((c) => allCenters.add(c.center));
        double avgLat =
            allCenters.map((c) => c.latitude).reduce((a, b) => a + b) /
            allCenters.length;
        double avgLng =
            allCenters.map((c) => c.longitude).reduce((a, b) => a + b) /
            allCenters.length;
        LatLng mapCenter = LatLng(avgLat, avgLng);
        // 3. 직업별로 각도를 다르게 하여 오프셋 적용
        final angleStep = 2 * 3.141592653589793 / JobType.values.length;
        final baseOffset = 0.004; // 기준 오프셋
        final offsetDistance = baseOffset * (14 / _currentZoom); // 줌에 따라 동적 조정
        int idx = 0;
        Map<JobType, List<ClusterWithRadius>> offsetClustersByType = {};
        for (var type in JobType.values) {
          double angle = angleStep * idx;
          double offsetLat = offsetDistance * cos(angle);
          double offsetLng = offsetDistance * sin(angle);
          offsetClustersByType[type] =
              clustersByType[type]!
                  .map(
                    (c) => ClusterWithRadius(
                      LatLng(
                        c.center.latitude + offsetLat,
                        c.center.longitude + offsetLng,
                      ),
                      c.items,
                      c.radius,
                    ),
                  )
                  .toList();
          idx++;
        }
        // 4. 마커 생성
        for (var type in JobType.values) {
          for (var group in offsetClustersByType[type]!) {
            int count = group.items.length;
            if (count == 0) continue;
            BitmapDescriptor icon = await getCustomClusterIcon(count, type);
            markers.add(
              Marker(
                markerId: MarkerId('${type}_${group.center}_$count'),
                position: group.center,
                icon: icon,
                onTap: () {
                  setState(() {
                    _selectedClusterItems = group.items;
                    _selectedMarkerId = null;
                  });
                  _draggableController.animateTo(
                    _maxChildSize,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
              ),
            );
          }
        }
      }
    } else {
      for (var item in filtered) {
        final user = item.data['user'];
        if (user == null) continue;
        String typeKey = user.jobType;
        bool isSelected = _selectedMarkerId == item.id;
        BitmapDescriptor icon =
            isSelected
                ? (selectedMarkerIcons[typeKey] ??
                    BitmapDescriptor.defaultMarker)
                : (normalMarkerIcons[typeKey] ??
                    BitmapDescriptor.defaultMarker);
        markers.add(
          Marker(
            markerId: MarkerId(item.id),
            position: item.position,
            icon: icon,
            onTap: () {
              setState(() {
                _selectedClusterItems = [item];
                _selectedMarkerId = item.id;
              });
              _draggableController.animateTo(
                _maxChildSize,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
          ),
        );
      }
    }
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

  // MemberType -> JobType 변환
  JobType? _memberTypeToJobType(MemberType? memberType) {
    switch (memberType) {
      case MemberType.family:
        return JobType.family;
      case MemberType.volunteer:
        return JobType.volunteer;
      case MemberType.caregiver:
        return JobType.caregiver;
      default:
        return null;
    }
  }

  // JobType -> MemberType 변환
  MemberType? _getMemberTypeFromJobType(JobType? jobType) {
    if (jobType == null) return null;
    switch (jobType) {
      case JobType.family:
        return MemberType.family;
      case JobType.volunteer:
        return MemberType.volunteer;
      case JobType.caregiver:
        return MemberType.caregiver;
    }
  }

  // 이름으로 사용자 검색
  void _searchUser(String searchText) {
    if (searchText.isEmpty) {
      setState(() {
        _selectedClusterItems = [];
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
        _selectedClusterItems = [
          ClusterItem(
            id: foundUser.first.id,
            position: foundUser.first.location,
            jobType:
                _memberTypeToJobType(
                  _getMemberTypeFromString(foundUser.first.jobType),
                )!,
            data: {'user': foundUser.first},
          ),
        ];
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
