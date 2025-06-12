import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:carely/utils/member_type.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/screens/map/clustering/cluster_item.dart';

/// 클러스터 크기별, 직업별 아이콘 생성 함수
Future<BitmapDescriptor> getCustomClusterIcon(
  int count,
  MemberType memberType,
) async {
  int size =
      count < 10
          ? 70
          : count < 40
          ? 100
          : 120; // 개수에 따라 원 크기 조절

  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  Paint paint;
  switch (memberType) {
    case MemberType.family:
      paint = Paint()..color = AppColors.red300.withValues(alpha: 0.5);
      break;
    case MemberType.volunteer:
      paint = Paint()..color = AppColors.blue300.withValues(alpha: 0.5);
      break;
    case MemberType.caregiver:
      paint = Paint()..color = AppColors.green300.withValues(alpha: 0.5);
      break;
  }

  // 원 그리기
  canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint);

  // 텍스트 설정
  TextPainter textPainter = TextPainter(
    text: TextSpan(
      text: count.toString(),
      style: TextStyle(
        fontSize: size / 3, // 숫자 크기 조절
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    textDirection: TextDirection.ltr,
  );

  textPainter.layout();
  textPainter.paint(
    canvas,
    Offset((size - textPainter.width) / 2, (size - textPainter.height) / 2),
  );

  final img = await pictureRecorder.endRecording().toImage(size, size);
  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  final Uint8List imageBytes = byteData!.buffer.asUint8List();

  return BitmapDescriptor.bytes(imageBytes);
}
