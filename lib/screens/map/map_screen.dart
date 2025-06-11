import 'dart:async';
import 'dart:typed_data';
import 'package:carely/screens/user_list.dart';
import 'package:carely/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carely/screens/map/marker_utils.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:carely/screens/map/user_info_card.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/screens/map/location_service.dart';
import 'package:carely/screens/map/filter_utilities.dart';
import 'package:carely/screens/map/clustering/cluster_item.dart'
    hide MemberType;
import 'package:carely/screens/map/clustering/cluster_manager.dart'
    as mycluster;
import 'package:carely/screens/map/clustering/cluster_helper.dart';
import 'package:carely/screens/map/clustering/custom_cluster_icon.dart';
import 'package:carely/screens/map/clustering/cluster_circle_offset.dart';
import 'package:carely/screens/map/clustering/avoid_cluster_overlap.dart';
import 'dart:math';
import 'package:carely/services/map/map_services.dart';
import 'package:carely/models/neighbor_member.dart' hide MemberType;
import 'package:carely/models/map_member.dart';
import 'package:carely/screens/profile_screen.dart';

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
  final double _clusterMaxChildSize = 0.65;
  late DraggableScrollableController _draggableController;
  double _currentSheetSize = 0.09;
  double _currentZoom = 14.5;
  bool _isClusterSelected = false;
  final List<ClusterItem> _allClusterItems = [];
  List<NeighborMember> _selectedClusterItems = [];

  Map<String, BitmapDescriptor> normalMarkerIcons = {};
  Map<String, BitmapDescriptor> selectedMarkerIcons = {};

  final Map<MemberType, Color> filterColors = {
    MemberType.family: AppColors.red300,
    MemberType.volunteer: AppColors.blue300,
    MemberType.caregiver: AppColors.green300,
  };

  final Map<MemberType, Color> filterInactiveColors = {
    MemberType.family: AppColors.red100,
    MemberType.volunteer: AppColors.blue100,
    MemberType.caregiver: AppColors.green100,
  };

  final LocationService _locationService = LocationService();
  List<NeighborMember> neighbors = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _draggableController = DraggableScrollableController();
    _initializeLocation();
    _fetchNeighborsFromApi();
    _draggableController.addListener(() {
      setState(() {
        _currentSheetSize = _draggableController.size;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadMarkerIcons();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _draggableController.dispose();
    super.dispose();
  }

  void _initializeLocation() async {
    await _locationService.initialize();
    _locationService.onLocationChanged((newPosition, address) {
      setState(() {
        _currentPosition = newPosition;
        _currentAddress = address;
      });
    });
  }

  void _loadMarkerIcons() async {
    try {
      final markerIcons = await MarkerUtils.loadAllMarkerIcons(
        context: context,
        normalSize: 64,
        selectedSize: 72,
        clusterSize: 80,
      );
      setState(() {
        normalMarkerIcons = markerIcons['normal']!;
        selectedMarkerIcons = markerIcons['selected']!;
      });
      logger.i('마커 아이콘 로드 성공: ${normalMarkerIcons.keys}');
    } catch (e, stackTrace) {
      logger.e('마커 아이콘 로드 실패: $e\n$stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<Set<Marker>>(
            future: _buildMarkersWithClusterIcons(),
            builder: (context, snapshot) {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target:
                      neighbors.isNotEmpty
                          ? LatLng(
                            neighbors[0].latitude,
                            neighbors[0].longitude,
                          )
                          : const LatLng(37.5665, 126.9780),
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
                    _isClusterSelected = false;
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
                                _searchNeighbor(value);
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const UserListScreen(),
                                  ),
                                );
                              },
                              customBorder: const CircleBorder(),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  'assets/images/user-list.svg',
                                  width: 28,
                                  height: 28,
                                ),
                              ),
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

          // 내 위치 버튼
          Positioned(
            bottom: _calculateMyLocationButtonPosition(),
            right: 8,
            child: InkWell(
              onTap: () {
                if (_currentPosition != null) {
                  _animateCameraToPosition(_currentPosition!);
                }
              },
              customBorder: const CircleBorder(), // Optional
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/images/my-location.svg',
                  width: 32,
                  height: 32,
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
            controller: _draggableController,
            initialChildSize: _minChildSize,
            minChildSize: _minChildSize,
            maxChildSize:
                _isClusterSelected ? _clusterMaxChildSize : _maxChildSize,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -2),
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
                    if (_selectedClusterItems.isNotEmpty)
                      if (_isClusterSelected)
                        Column(
                          children:
                              _selectedClusterItems
                                  .map(
                                    (item) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: UserInfoCard(
                                        memberId: item.memberId,
                                        neighborData: item,
                                      ),
                                    ),
                                  )
                                  .toList(),
                        )
                      else if (_selectedClusterItems.length == 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: UserInfoCard(
                            memberId: _selectedClusterItems.first.memberId,
                            neighborData: _selectedClusterItems.first,
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

  double _calculateMyLocationButtonPosition() {
    return MediaQuery.of(context).size.height * _currentSheetSize;
  }

  Widget _buildResetFilterButton() {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilters.clear();
        });
      },
      customBorder: const CircleBorder(), // Optional
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          'assets/images/reset.svg',
          width: 32,
          height: 32,
        ),
      ),
    );
  }

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
    logger.i(
      '🗺️ 마커 생성 시작 - neighbors: ${neighbors.length}, _allClusterItems: ${_allClusterItems.length}',
    );

    Set<Marker> markers = {};
    List<ClusterItem> filtered =
        _allClusterItems.where((item) {
          if (_searchText.isNotEmpty) {
            final user = item.data['user'];
            if (user == null ||
                !user['name'].toLowerCase().contains(
                  _searchText.toLowerCase(),
                )) {
              return false;
            }
          }
          if (_selectedFilters.isNotEmpty) {
            if (!_selectedFilters.contains(item.memberType)) {
              return false;
            }
          }
          return true;
        }).toList();

    logger.i('🗺️ 필터링 후 아이템: ${filtered.length}개');

    if (_currentZoom <= 14.2) {
      logger.i('🗺️ 클러스터링 모드 - 줌: $_currentZoom');
      final bounds = await _mapController?.getVisibleRegion();
      if (bounds != null) {
        final diag = ClusterHelper.distance(bounds.southwest, bounds.northeast);
        final clusterRadius = diag / 8;
        Map<MemberType, List<ClusterWithRadius>> clustersByType = {};
        for (var type in MemberType.values) {
          final itemsOfType =
              filtered.where((e) => e.memberType == type).toList();
          final clusters = ClusterHelper.cluster(itemsOfType, clusterRadius);
          clustersByType[type] = avoidClusterOverlap(clusters);
        }

        int totalClusters = clustersByType.values
            .map((list) => list.length)
            .reduce((a, b) => a + b);
        logger.i('🗺️ 클러스터 생성 완료: $totalClusters개');

        List<LatLng> allCenters = [];
        clustersByType.values
            .expand((list) => list)
            .forEach((c) => allCenters.add(c.center));
        double avgLat =
            allCenters.isNotEmpty
                ? allCenters.map((c) => c.latitude).reduce((a, b) => a + b) /
                    allCenters.length
                : 0;
        double avgLng =
            allCenters.isNotEmpty
                ? allCenters.map((c) => c.longitude).reduce((a, b) => a + b) /
                    allCenters.length
                : 0;
        LatLng mapCenter = LatLng(avgLat, avgLng);
        final angleStep = 2 * pi / MemberType.values.length;
        final baseOffset = 0.004;
        final offsetDistance = baseOffset * (14 / _currentZoom);
        int idx = 0;
        Map<MemberType, List<ClusterWithRadius>> offsetClustersByType = {};
        for (var type in MemberType.values) {
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
        for (var type in MemberType.values) {
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
                    _selectedClusterItems =
                        group.items.map((item) {
                          final originalNeighbor = neighbors.firstWhere(
                            (n) => n.memberId.toString() == item.id,
                            orElse: () => neighbors.first,
                          );
                          return originalNeighbor;
                        }).toList();
                    _selectedMarkerId = null;
                    _isClusterSelected = true;
                  });

                  double targetSize =
                      group.items.length >= 3
                          ? _clusterMaxChildSize
                          : _maxChildSize;

                  _draggableController.animateTo(
                    targetSize,
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
      logger.i('🗺️ 개별 마커 모드 - 줌: $_currentZoom');
      // 클러스터링이 해제된 경우, 개별 마커 위치를 오직 원본 사용자 location에 고정
      for (var item in _allClusterItems) {
        final user = item.data['user'];
        if (user == null) continue;
        // 필터 및 검색 조건 적용
        if (_searchText.isNotEmpty &&
            !user['name'].toLowerCase().contains(_searchText.toLowerCase())) {
          continue;
        }
        if (_selectedFilters.isNotEmpty &&
            !_selectedFilters.contains(item.memberType)) {
          continue;
        }
        bool isSelected = _selectedMarkerId == item.id;

        int markerSize = isSelected ? 45 : 40;

        final String memberType = user['memberType'];

        final markerIcon = await MarkerUtils.loadmemberTypeMarker(
          context,
          memberType,
          isSelected: isSelected,
          size: Size(markerSize.toDouble(), markerSize.toDouble()),
        );

        final icon = markerIcon;

        markers.add(
          Marker(
            markerId: MarkerId(item.id),
            position: item.position,
            icon: icon,
            anchor: const Offset(0.5, 1.0),
            zIndex: isSelected ? 1.0 : 0.0,
            onTap: () {
              setState(() {
                _selectedMarkerId = item.id;
                _isClusterSelected = false;
                _selectedClusterItems = [
                  neighbors.firstWhere(
                    (n) => n.memberId.toString() == item.id,
                    orElse: () => neighbors.first,
                  ),
                ];
              });
              _draggableController.animateTo(
                _maxChildSize,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
              _mapController?.animateCamera(
                CameraUpdate.newLatLng(item.position),
              );
            },
          ),
        );
      }
    }

    logger.i('🗺️ 마커 생성 완료: ${markers.length}개');
    return markers;
  }

  MemberType _stringToMemberType(String type) {
    switch (type.toLowerCase()) {
      case 'family':
        return MemberType.family;
      case 'volunteer':
        return MemberType.volunteer;
      case 'caregiver':
        return MemberType.caregiver;
      default:
        return MemberType.family;
    }
  }

  void _searchNeighbor(String searchText) {
    if (searchText.isEmpty) {
      setState(() {
        _selectedClusterItems = [];
      });
      return;
    }

    final found =
        neighbors
            .where(
              (n) =>
                  n.memberId.toString() == searchText ||
                  n.name.toLowerCase().contains(searchText.toLowerCase()),
            )
            .toList();

    if (found.isNotEmpty) {
      setState(() {
        _selectedClusterItems = [found.first];
      });
      _animateCameraToPosition(
        LatLng(
          double.parse(found.first.latitude.toString()),
          double.parse(found.first.longitude.toString()),
        ),
      );
      _draggableController.animateTo(
        _clusterMaxChildSize,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _animateCameraToPosition(LatLng position) {
    _mapController?.animateCamera(CameraUpdate.newLatLng(position));
  }

  void _resetFiltersAndCamera() {
    setState(() {
      _selectedFilters.clear();
    });
    _animateCameraToPosition(
      neighbors.isNotEmpty
          ? LatLng(
            double.parse(neighbors.first.latitude.toString()),
            double.parse(neighbors.first.longitude.toString()),
          )
          : const LatLng(37.5665, 126.9780),
    );
  }

  Future<void> _fetchNeighborsFromApi() async {
    try {
      logger.i('🔍 지도용 이웃 목록 API 호출 시작');
      final data = await MapServices.fetchNeighbors();
      logger.i('✅ 지도용 이웃 목록 API 응답: ${data.length}명의 이웃');

      if (data.isNotEmpty) {
        logger.i('📋 첫 번째 이웃: ${data.first}');
        logger.i(
          '📋 첫 번째 이웃 위치: ${data.first.latitude}, ${data.first.longitude}',
        );
      } else {
        logger.w('⚠️ 이웃 데이터가 비어있습니다');
      }

      // neighbors를 _allClusterItems로 변환
      _allClusterItems.clear();
      logger.i('🔄 ClusterItem 변환 시작: ${data.length}명의 neighbor');

      for (int i = 0; i < data.length; i++) {
        final neighbor = data[i];
        try {
          logger.i(
            '📋 neighbor $i: memberId=${neighbor.memberId}, name=${neighbor.name}, lat=${neighbor.latitude}, lng=${neighbor.longitude}',
          );

          _allClusterItems.add(
            ClusterItem(
              id: neighbor.memberId.toString(),
              position: LatLng(
                double.parse(neighbor.latitude.toString()),
                double.parse(neighbor.longitude.toString()),
              ),
              memberType: _stringToMemberType(neighbor.memberType.name),
              data: {
                'user': {
                  'name': neighbor.name,
                  'memberType': neighbor.memberType.name,
                  'withTime': neighbor.withTime ?? 0,
                  'distance': neighbor.distance,
                },
              },
            ),
          );
          logger.i('✅ ClusterItem 생성 성공: ${neighbor.memberId}');
        } catch (e) {
          logger.e('❌ ClusterItem 생성 실패 - neighbor $i: $e');
          logger.e('❌ 실패한 neighbor 데이터: $neighbor');
        }
      }
      logger.i('🔄 _allClusterItems 업데이트 완료: ${_allClusterItems.length}개 아이템');

      setState(() {
        neighbors = data;
        isLoading = false;
      });
      logger.i('🔄 지도 UI 업데이트 완료: ${neighbors.length}명의 이웃');
    } catch (e) {
      logger.e('❌ 지도용 이웃 목록 API 호출 실패: $e');
      setState(() => isLoading = false);
    }
  }

  void _onUserInfoCardTap(int memberId) async {
    final detail = await MapServices.fetchMemberDetail(memberId);
    if (detail != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProfileScreen(member: detail)),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('멤버 정보를 불러올 수 없습니다.')));
    }
  }
}
