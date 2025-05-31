import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart' as geo;
import 'package:carely/utils/logger_config.dart';

typedef LocationCallback = void Function(LatLng position, String? address);

class LocationService {
  // 싱글톤 패턴 구현
  static final LocationService _instance = LocationService._internal();
  
  factory LocationService() {
    return _instance;
  }
  
  LocationService._internal();
  
  final loc.Location locationController = loc.Location();
  LocationCallback? _locationCallback;
  LatLng? _lastPosition;
  
  // 마지막으로 변환된 위치 정보 저장
  LatLng? lastKnownPosition;
  String? lastKnownAddress;

  /// 위치 서비스 초기화
  Future<bool> initialize() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    // 위치 서비스 활성화 확인
    serviceEnabled = await locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationController.requestService();
      if (!serviceEnabled) return false;
    }

    // 위치 권한 확인
    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return false;
    }

    // 위치 변경 리스너 등록
    locationController.onLocationChanged.listen(_handleLocationChange);

    return true;
  }

  /// 위치 업데이트 콜백 등록
  void onLocationChanged(LocationCallback callback) {
    _locationCallback = callback;
  }

  /// 위치 변경 이벤트 처리
  void _handleLocationChange(loc.LocationData currentLocation) async {
    if (currentLocation.latitude != null && currentLocation.longitude != null) {
      LatLng position = LatLng(
        currentLocation.latitude!,
        currentLocation.longitude!,
      );

      // 주소 변환
      String? address = await getAddressFromLatLng(position);
      
      // 마지막 알려진 위치 정보 업데이트
      lastKnownPosition = position;
      lastKnownAddress = address;

      // 콜백 호출
      if (_locationCallback != null) {
        _locationCallback!(position, address);
      }
      if (_lastPosition != null) {
        double distance = _calculateDistance(_lastPosition!, position);
        if (distance < 10) return;
      }
    }
  }

  /// 위도/경도로부터 주소 정보 가져오기
  Future<String?> getAddressFromLatLng(LatLng position) async {
    try {
      // 이미 저장된 주소가 있고 동일한 위치인 경우 캡시 처리
      if (lastKnownPosition != null && 
          lastKnownAddress != null &&
          _calculateDistance(lastKnownPosition!, position) < 10) {
        return lastKnownAddress;
      }
      
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        String address = [
          p.administrativeArea,
          p.subAdministrativeArea,
          p.locality,
          p.subLocality,
        ].where((e) => e != null && e.isNotEmpty).join(' ');
        
        // 마지막 알려진 위치 정보 업데이트
        lastKnownPosition = position;
        lastKnownAddress = address;
        
        return address;
      }
    } catch (e) {
      logger.e('주소 변환 실패: $e');
    }
    return null;
  }

  double _calculateDistance(LatLng pos1, LatLng pos2) {
    const double earthRadius = 6371000; // 지구 반지름 (미터)
    double lat1 = pos1.latitude * (pi / 180);
    double lat2 = pos2.latitude * (pi / 180);
    double lon1 = pos1.longitude * (pi / 180);
    double lon2 = pos2.longitude * (pi / 180);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }
}
