import 'package:flutter/material.dart';

// 📌 iPhone 13 Mini(376 기준)에서의 비율 계산
class ScreenSize {
  static double width(BuildContext context, double size) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * (size / 376); // 기준 기기(376) 대비 비율 적용
  }

  static double height(BuildContext context, double size) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * (size / 376); // 기준 기기(376) 대비 비율 적용
  }
}
