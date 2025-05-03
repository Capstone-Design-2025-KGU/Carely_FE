import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carely/screens/map/clustering/cluster_helper.dart';
import 'package:carely/screens/map/clustering/cluster_item.dart';

class ClusterWithRadius {
  LatLng center;
  final List<ClusterItem> items;
  double radius; // meter

  ClusterWithRadius(this.center, this.items, this.radius);
}

/// 마커 수에 따라 반경을 계산
double calcClusterRadius(int count) {
  return 40 + 5 * sqrt(count);
}

/// 클러스터 원이 겹치지 않게 오프셋 적용
List<ClusterWithRadius> avoidClusterOverlap(List<ClusterGroup> clusters) {
  // 1. 각 클러스터의 반경 계산
  List<ClusterWithRadius> result =
      clusters
          .map(
            (g) => ClusterWithRadius(
              g.center,
              g.items,
              calcClusterRadius(g.items.length),
            ),
          )
          .toList();

  // 2. 반복적으로 겹침 해소
  const int maxIter = 20;
  for (int iter = 0; iter < maxIter; iter++) {
    for (int i = 0; i < result.length; i++) {
      for (int j = i + 1; j < result.length; j++) {
        final a = result[i];
        final b = result[j];
        double dist = ClusterHelper.distance(a.center, b.center);
        double minDist = a.radius + b.radius;
        if (dist < minDist && dist > 0) {
          // 겹침 → 두 클러스터를 서로 멀어지게 이동
          double move = (minDist - dist) / 2;
          double dx = b.center.latitude - a.center.latitude;
          double dy = b.center.longitude - a.center.longitude;
          double len = sqrt(dx * dx + dy * dy);
          if (len == 0) continue;
          double offsetLat = dx / len * move * 0.0000089; // 위도 1m ≈ 0.0000089
          double offsetLng =
              dy / len * move * 0.0000113; // 경도 1m ≈ 0.0000113 (서울 기준)
          a.center = LatLng(
            a.center.latitude - offsetLat,
            a.center.longitude - offsetLng,
          );
          b.center = LatLng(
            b.center.latitude + offsetLat,
            b.center.longitude + offsetLng,
          );
        }
      }
    }
  }
  return result;
}
