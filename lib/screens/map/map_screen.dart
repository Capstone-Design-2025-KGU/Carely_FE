import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart' as geo;
import 'package:carely/screens/map/marker_utils.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:carely/screens/map/user_info_card.dart';
import 'package:carely/screens/map/dummy_data.dart';

class MapScreen extends StatefulWidget {
  static String id = 'map-screen';
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  final loc.Location _locationController = loc.Location();
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  String? _selectedMarkerId;
  String? _currentAddress;

  final double _minChildSize = 0.125;
  final double _maxChildSize = 0.35;
  late DraggableScrollableController _draggableController;

  Map<String, BitmapDescriptor> normalMarkerIcons = {};
  Map<String, BitmapDescriptor> selectedMarkerIcons = {};

  @override
  void initState() {
    super.initState();
    _draggableController = DraggableScrollableController();
    _loadMarkerIcons();
    _getLocationUpdates();
  }

  @override
  void dispose() {
    _draggableController.dispose();
    super.dispose();
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
            markers: _getMarkers(),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
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
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
          ),

          // DraggableScrollableSheet
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

  /// 마커 생성
  Set<Marker> _getMarkers() {
    Set<Marker> markers = {};

    for (var user in dummyUsers) {
      bool isSelected = user.id == _selectedMarkerId;

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
              duration: Duration(milliseconds: 300),
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

  /// 현재 위치 가져오기
  Future<void> _getLocationUpdates() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return;
    }

    _locationController.onLocationChanged.listen((
      loc.LocationData currentLocation,
    ) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        LatLng newPosition = LatLng(
          currentLocation.latitude!,
          currentLocation.longitude!,
        );
        setState(() {
          _currentPosition = newPosition;
        });
        _getAddressFromLatLng(newPosition);
      }
    });
  }

  /// 주소 변환
  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        setState(() {
          _currentAddress =
              '${placemarks.first.locality}, ${placemarks.first.subLocality}';
        });
      }
    } catch (e) {
      logger.e('주소 변환 실패: $e');
    }
  }

  /// 카메라 이동 애니메이션
  void _animateCameraToPosition(LatLng position) {
    _mapController?.animateCamera(CameraUpdate.newLatLng(position));
  }
}
