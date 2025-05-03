import 'dart:math' as Math;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carely/screens/map/clustering/cluster_helper.dart';
import 'package:carely/screens/map/clustering/cluster_item.dart';

/// 직업별 클러스터 원이 겹치지 않도록 오프셋을 적용
Map<JobType, ClusterGroup> offsetClusterCircle(
  Map<JobType, ClusterGroup> clusters,
) {
  // 중심점 계산 (모든 클러스터의 평균)
  final nonEmpty = clusters.values.where((g) => g.items.isNotEmpty).toList();
  if (nonEmpty.isEmpty) return clusters;
  double latSum = 0;
  double lngSum = 0;
  for (var group in nonEmpty) {
    latSum += group.center.latitude;
    lngSum += group.center.longitude;
  }
  double latAvg = latSum / nonEmpty.length;
  double lngAvg = lngSum / nonEmpty.length;
  LatLng mapCenter = LatLng(latAvg, lngAvg);

  // 각 직업별로 각도를 다르게 하여 오프셋 적용
  final angleStep = 360 / clusters.length;
  final offsetDistance = 0.0007; // 위도/경도 단위(약 200m), 필요시 조정
  int idx = 0;
  Map<JobType, ClusterGroup> result = {};
  for (var entry in clusters.entries) {
    final jobType = entry.key;
    final group = entry.value;
    if (group.items.isEmpty) {
      result[jobType] = group;
      continue;
    }
    double angle = angleStep * idx;
    double rad = angle * 3.141592653589793 / 180.0;
    double offsetLat = mapCenter.latitude + offsetDistance * MathUtils.cos(rad);
    double offsetLng =
        mapCenter.longitude + offsetDistance * MathUtils.sin(rad);
    result[jobType] = ClusterGroup(LatLng(offsetLat, offsetLng), group.items);
    idx++;
  }
  return result;
}

class MathUtils {
  static double sin(double x) => MathUtils._sin(x);
  static double cos(double x) => MathUtils._cos(x);
  static double _sin(double x) => Math.sin(x);
  static double _cos(double x) => Math.cos(x);
}
