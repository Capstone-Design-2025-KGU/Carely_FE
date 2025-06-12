import 'package:carely/utils/member_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import 'package:carely/screens/map/clustering/cluster_item.dart';

class ClusterGroup {
  final LatLng center;
  final List<ClusterItem> items;

  ClusterGroup(this.center, this.items);
}

class ClusterHelper {
  /// 거리 기반 클러스터링 (radius: 미터)
  static List<ClusterGroup> cluster(List<ClusterItem> items, double radius) {
    List<ClusterGroup> clusters = [];
    for (var item in items) {
      bool added = false;
      for (var group in clusters) {
        if (distance(item.position, group.center) < radius) {
          group.items.add(item);
          added = true;
          break;
        }
      }
      if (!added) {
        clusters.add(ClusterGroup(item.position, [item]));
      }
    }
    return clusters;
  }

  /// 직업별로 하나의 클러스터만 생성 (중심은 평균 좌표)
  static ClusterGroup singleCluster(List<ClusterItem> items) {
    if (items.isEmpty) return ClusterGroup(LatLng(0, 0), []);
    double latSum = 0;
    double lngSum = 0;
    for (var item in items) {
      latSum += item.position.latitude;
      lngSum += item.position.longitude;
    }
    double latAvg = latSum / items.length;
    double lngAvg = lngSum / items.length;
    return ClusterGroup(LatLng(latAvg, lngAvg), items);
  }

  static Map<MemberType, ClusterGroup> clusterByMemberTypeSingleCluster(
    List<ClusterItem> items,
  ) {
    Map<MemberType, List<ClusterItem>> byType = {};
    for (var type in MemberType.values) {
      byType[type] = [];
    }
    for (var item in items) {
      byType[item.memberType]?.add(item);
    }
    Map<MemberType, ClusterGroup> result = {};
    for (var type in MemberType.values) {
      result[type] = singleCluster(byType[type]!);
    }
    return result;
  }

  static double _getRadiusByZoom(double zoom) {
    return 1000 / zoom; // 미터 단위 등으로 조정
  }

  /// 두 좌표 간 거리 (미터)
  static double distance(LatLng a, LatLng b) {
    // Haversine formula (단순화)
    const double R = 6371000; // 지구 반지름 (m)
    double dLat = _deg2rad(b.latitude - a.latitude);
    double dLon = _deg2rad(b.longitude - a.longitude);
    double lat1 = _deg2rad(a.latitude);
    double lat2 = _deg2rad(b.latitude);
    double aVal =
        (sin(dLat / 2) * sin(dLat / 2)) +
        cos(lat1) * cos(lat2) * (sin(dLon / 2) * sin(dLon / 2));
    double c = 2 * atan2(sqrt(aVal), sqrt(1 - aVal));
    return R * c;
  }

  static double _deg2rad(double deg) => deg * (3.141592653589793 / 180.0);
}
