import 'dart:async';
import 'dart:ffi';

import 'package:carely/utils/logger_config.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  static String id = 'map-screen';
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Location _locationController = Location();
  GoogleMapController? _mapController;
  bool _isMapLoaded = false;

  Map<String, BitmapDescriptor> markerIcons = {
    'family': BitmapDescriptor.defaultMarker,
    'volunteer': BitmapDescriptor.defaultMarker,
    'caregiver': BitmapDescriptor.defaultMarker,
  };

  // 위치별 직업 유형 정보
  final Map<String, String> locationTypes = {
    '_Seoul': 'family',
    '_Seoul1': 'family',
    '_Seoul2': 'volunteer',
    '_Seoul3': 'caregiver',
    '_Seoul4': 'caregiver',
  };

  @override
  void initState() {
    loadMarkerIcons();
    getLocationUpdates();
    super.initState();
  }

  // 마커 아이콘 로드
  void loadMarkerIcons() {
    // 간병인 마커 (Red)
    BitmapDescriptor.asset(
      const ImageConfiguration(),
      'assets/images/Red.png',
    ).then((icon) {
      setState(() {
        markerIcons['family'] = icon;
        logger.i('간병인 마커 로드 성공');
      });
    });

    // 자원봉사자 마커 (Blue)
    BitmapDescriptor.asset(
      const ImageConfiguration(),
      'assets/images/Blue.png',
    ).then((icon) {
      setState(() {
        markerIcons['volunteer'] = icon;
        logger.i('자원봉사자 마커 로드 성공');
      });
    });

    // 요양보호사 마커 (Green)
    BitmapDescriptor.asset(
      const ImageConfiguration(),
      'assets/images/Green.png',
    ).then((icon) {
      setState(() {
        markerIcons['caregiver'] = icon;
        logger.i('요양보호사 마커 로드 성공');
      });
    });
  }

  static const LatLng _Seoul = LatLng(37.5665, 126.9780);
  static const LatLng _Seoul1 = LatLng(37.5651, 126.9895);
  static const LatLng _Seoul2 = LatLng(37.5641, 126.9755);
  static const LatLng _Seoul3 = LatLng(37.5678, 126.9774);
  static const LatLng _Seoul4 = LatLng(37.5685, 126.9862);
  LatLng? _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(target: _Seoul, zoom: 14),
        markers: _getMarkers(),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
          _isMapLoaded = true; // 지도 로드 완료 표시
          Future.delayed(const Duration(milliseconds: 500), () {
            getVisibleBounds(); // 일정 시간 후 getVisibleBounds() 실행
          });
        },
      ),
    );
  }

  // 직업 유형에 따른 마커 생성
  Set<Marker> _getMarkers() {
    // 각 위치와 해당 위치의 LatLng 매핑
    final Map<String, LatLng> locations = {
      '_Seoul': _Seoul,
      '_Seoul1': _Seoul1,
      '_Seoul2': _Seoul2,
      '_Seoul3': _Seoul3,
      '_Seoul4': _Seoul4,
    };

    Set<Marker> markers = {};

    // 각 위치에 대해 마커 생성
    locations.forEach((markerId, position) {
      // 해당 위치의 직업 유형 가져오기
      String jobType = locationTypes[markerId] ?? 'family';

      // 해당 직업 유형의 마커 아이콘 가져오기
      BitmapDescriptor icon =
          markerIcons[jobType] ?? BitmapDescriptor.defaultMarker;

      // 마커 추가
      markers.add(
        Marker(
          markerId: MarkerId(markerId),
          icon: icon,
          position: position,
          infoWindow: InfoWindow(title: jobType),
        ),
      );
    });

    // 현재 위치 마커 추가
    if (_currentPosition != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('_currentLocation'),
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

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged.listen((
      LocationData currentLocation,
    ) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentPosition = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );
        });
        // 현재 위치로 카메라 이동
        _updateCameraPosition(_currentPosition!);
        logger.i(_currentPosition);
      }
    });
  }

  void _updateCameraPosition(LatLng position) {
    _mapController?.animateCamera(CameraUpdate.newLatLng(position));
  }

  // 부표트 좌표 확인 (아직 미사용)
  Future<void> getVisibleBounds() async {
    if (!_isMapLoaded || _mapController == null) {
      logger.e('GoogleMapController가 아직 초기화되지 않았습니다.');
      return;
    }

    try {
      LatLngBounds bounds = await _mapController!.getVisibleRegion();

      // 남서쪽(좌측 하단) 좌표
      LatLng southWest = bounds.southwest;

      // 북동쪽(우측 상단) 좌표
      LatLng northEast = bounds.northeast;

      logger.i('south :${southWest.latitude}, ${southWest.longitude}');
      logger.i('north :${northEast.latitude}, ${northEast.longitude}');
    } catch (e) {
      logger.e('getVisibleBounds() 실행 중 오류 발생: $e');
    }
  }
}
