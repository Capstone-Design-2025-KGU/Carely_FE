import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart' as geo;
import 'package:carely/utils/logger_config.dart';

typedef LocationCallback = void Function(LatLng position, String? address);

class LocationService {
  final loc.Location _locationController = loc.Location();
  LocationCallback? _locationCallback;
  LatLng? _lastPosition;

  /// 위치 서비스 초기화
  Future<bool> initialize() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    // 위치 서비스 활성화 확인
    serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) return false;
    }

    // 위치 권한 확인
    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return false;
    }

    // 위치 변경 리스너 등록
    _locationController.onLocationChanged.listen(_handleLocationChange);

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
      String? address = await _getAddressFromLatLng(position);

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
  Future<String?> _getAddressFromLatLng(LatLng position) async {
    try {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        return [p.administrativeArea, p.subAdministrativeArea, p.locality, p.subLocality]
            .where((e) => e != null && e.isNotEmpty)
            .join(' ');
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
