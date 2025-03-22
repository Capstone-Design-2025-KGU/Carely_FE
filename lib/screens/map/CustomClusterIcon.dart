import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// 클러스터 크기별 아이콘 생성 함수
Future<BitmapDescriptor> getCustomClusterIcon(int count) async {
  int size =
      count < 10
          ? 80
          : count < 50
          ? 100
          : 120; // 개수에 따라 원 크기 조절

  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint paint = Paint()..color = Colors.redAccent; // 원 색상

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

  return BitmapDescriptor.fromBytes(imageBytes);
}
