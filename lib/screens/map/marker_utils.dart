import 'dart:async';
import 'dart:ui' as ui;
import 'package:carely/utils/logger_config.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerUtils {
  static Future<BitmapDescriptor> loadCustomMarker(
    String assetPath,
    int size,
  ) async {
    try {
      final ByteData data = await rootBundle.load(assetPath);
      final ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: size,
        targetHeight: size,
      );
      final ui.FrameInfo fi = await codec.getNextFrame();
      final Uint8List markerBytes =
          (await fi.image.toByteData(
            format: ui.ImageByteFormat.png,
          ))!.buffer.asUint8List();
      return BitmapDescriptor.bytes(markerBytes);
    } catch (e) {
      logger.i('Error loading marker: $e');
      return BitmapDescriptor.defaultMarker;
    }
  }

  /// 직업 타입별 마커 아이콘 로드
  static Future<Map<String, Map<String, BitmapDescriptor>>> loadAllMarkerIcons({
    int normalSize = 40,
    int selectedSize = 50,
  }) async {
    // 아이콘 종류에 따른 에셋 경로 매핑
    Map<String, String> iconAssets = {
      'family': 'assets/images/markers/Red.png',
      'volunteer': 'assets/images/markers/Blue.png',
      'caregiver': 'assets/images/markers/Green.png',
    };

    // 결과를 저장할 맵 초기화
    Map<String, BitmapDescriptor> normalMarkerIcons = {};
    Map<String, BitmapDescriptor> selectedMarkerIcons = {};

    // 모든 아이콘 타입에 대해 로드
    for (String type in iconAssets.keys) {
      String assetPath = iconAssets[type]!;

      normalMarkerIcons[type] = await loadCustomMarker(assetPath, normalSize);
      selectedMarkerIcons[type] = await loadCustomMarker(
        assetPath,
        selectedSize,
      );
    }

    return {'normal': normalMarkerIcons, 'selected': selectedMarkerIcons};
  }
}
