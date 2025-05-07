import 'package:carely/screens/map/clustering/cluster_item.dart';
import 'package:carely/screens/map/clustering/cluster_helper.dart';

class ClusterManager {
  final List<ClusterItem> items;

  ClusterManager(this.items);

  /// 줌 레벨, 직업별로 클러스터링
  Map<JobType, List<ClusterGroup>> clusterByJobType(double zoom) {
    Map<JobType, List<ClusterGroup>> result = {};
    for (var type in JobType.values) {
      final filtered = items.where((e) => e.jobType == type).toList();
      result[type] = ClusterHelper.cluster(filtered, zoom);
    }
    return result;
  }
}
