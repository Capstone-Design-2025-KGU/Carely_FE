// marker_utils.dart
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:carely/theme/colors.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

// navigatorKey를 사용하기 위한 전역 키 선언 (main.dart에서 이 키를 사용해야 함)
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MarkerUtils {
  // 직업별 색상 (마커 배경 등 활용)
  static final Map<String, Color> jobTypeColors = {
    'family': AppColors.red200,
    'volunteer': AppColors.blue200,
    'caregiver': AppColors.green200,
    'default': AppColors.gray300,
  };

  static final Map<String, BitmapDescriptor> _preloadedClusterIcons = {};
  static final Map<String, Uint8List> _pngCache = {};
  static final Map<String, BitmapDescriptor> _markerCache = {};

  static get markerType => null;

  /// PNG 이미지를 바이트로 로드
  static Future<Uint8List> loadPngAsBytes(
    BuildContext context,
    String assetPath,
    Size size,
  ) async {
    try {
      final String cacheKey = '$assetPath|${size.width}x${size.height}';
      if (_pngCache.containsKey(cacheKey)) return _pngCache[cacheKey]!;

      final ByteData data = await DefaultAssetBundle.of(
        context,
      ).load(assetPath);
      final ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: size.width.toInt(),
        targetHeight: size.height.toInt(),
      );
      final ui.FrameInfo fi = await codec.getNextFrame();
      final ByteData? bytes = await fi.image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (bytes == null)
        throw Exception('Failed to convert image to PNG bytes');

      final Uint8List pngBytes = bytes.buffer.asUint8List();
      _pngCache[cacheKey] = pngBytes;
      return pngBytes;
    } catch (e) {
      logger.e('Error loading PNG $assetPath: $e');
      rethrow;
    }
  }

  /// 직업별 SVG 마커 로드
  static Future<BitmapDescriptor> loadJobTypeMarker(
    BuildContext context,
    String jobType, {
    bool isSelected = false,
    Size size = const Size(40, 60),
  }) async {
    final String markerType = isSelected ? 'selected' : 'normal';
    final String cacheKey = '$jobType|$markerType|${size.width}x${size.height}';

    // 직업 유형에 따른 마커 색상 결정
    String markerColor;
    switch (jobType) {
      case 'family':
        markerColor = 'Red';
        break;
      case 'volunteer':
        markerColor = 'Blue';
        break;
      case 'caregiver':
        markerColor = 'Green';
        break;
      default:
        markerColor = 'Red';
    }

    final String markerPath = 'assets/images/markers/$markerColor.png';

    try {
      if (_markerCache.containsKey(cacheKey)) return _markerCache[cacheKey]!;
      logger.i(
        '마커 PNG 경로: $markerPath (jobType: $jobType, markerType: $markerType, color: $markerColor)',
      );

      final Uint8List pngBytes = await loadPngAsBytes(
        context,
        markerPath,
        size,
      );

      final BitmapDescriptor descriptor = BitmapDescriptor.bytes(pngBytes);
      _markerCache[cacheKey] = descriptor;
      return descriptor;
    } catch (e) {
      logger.e(
        'Error loading job type marker - Path: $markerPath, JobType: $jobType, Error: $e',
      );
      return BitmapDescriptor.defaultMarker;
    }
  }

  /// PNG/JPG 마커 로드
  static Future<BitmapDescriptor> loadCustomMarker(
    BuildContext context,
    String assetPath,
    int size,
  ) async {
    try {
      final String cacheKey = '$assetPath|$size';
      if (_markerCache.containsKey(cacheKey)) return _markerCache[cacheKey]!;

      final ByteData data = await DefaultAssetBundle.of(
        context,
      ).load(assetPath);
      final ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: size,
        targetHeight: size,
      );
      final ui.FrameInfo fi = await codec.getNextFrame();
      final ByteData? bytes = await fi.image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      if (bytes == null) {
        throw Exception('Failed to convert image to PNG bytes');
      }

      final BitmapDescriptor descriptor = BitmapDescriptor.bytes(
        bytes.buffer.asUint8List(),
      );
      _markerCache[cacheKey] = descriptor;
      return descriptor;
    } catch (e) {
      logger.e('Error loading custom marker $assetPath: $e');
      return BitmapDescriptor.defaultMarker;
    }
  }

  /// 모든 타입의 마커 아이콘 로드
  static Future<Map<String, Map<String, BitmapDescriptor>>> loadAllMarkerIcons({
    // 기본 마커 크기를 키워봅니다. (예: 40 -> 64, 50 -> 80)
    // 실제 앱에서는 다양한 디바이스 해상도를 고려하여 적절한 크기를 찾아야 합니다.
    int normalSize = 64,
    int selectedSize = 80,
    int clusterSize = 70,
    BuildContext? context,
  }) async {
    Map<String, String> iconAssets = {
      'family': 'assets/images/markers/Red.png',
      'volunteer': 'assets/images/markers/Blue.png',
      'caregiver': 'assets/images/markers/Green.png',
    };
    Map<String, BitmapDescriptor> normalMarkerIcons = {};
    Map<String, BitmapDescriptor> selectedMarkerIcons = {};

    final BuildContext currentContext = context ?? navigatorKey.currentContext!;
    final List<Future<void>> futures = [];

    for (String type in iconAssets.keys) {
      String assetPath = iconAssets[type]!;
      futures.addAll([
        loadJobTypeMarker(
          currentContext,
          type,
          isSelected: false,
          size: Size(normalSize.toDouble(), normalSize.toDouble()),
        ).then((descriptor) => normalMarkerIcons[type] = descriptor),
        loadJobTypeMarker(
          currentContext,
          type,
          isSelected: true,
          size: Size(selectedSize.toDouble(), selectedSize.toDouble()),
        ).then((descriptor) => selectedMarkerIcons[type] = descriptor),
        loadJobTypeMarker(
          currentContext,
          type,
          isSelected: false,
          size: Size(clusterSize.toDouble(), clusterSize.toDouble()),
        ).then((descriptor) => _preloadedClusterIcons[type] = descriptor),
      ]);
    }

    await Future.wait(futures);
    return {'normal': normalMarkerIcons, 'selected': selectedMarkerIcons};
  }

  /// 클러스터 마커용 아이콘 반환
  static BitmapDescriptor? getPreloadedClusterIcon(String type) {
    return _preloadedClusterIcons[type];
  }
}
