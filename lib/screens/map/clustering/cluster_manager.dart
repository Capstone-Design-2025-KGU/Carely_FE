import 'package:carely/screens/map/clustering/cluster_item.dart';
import 'package:carely/screens/map/clustering/cluster_helper.dart';
import 'package:carely/utils/member_type.dart';

class ClusterManager {
  final List<ClusterItem> items;

  ClusterManager(this.items);

  /// 줌 레벨, 직업별로 클러스터링
  Map<MemberType, List<ClusterGroup>> clusterByMemberType(double zoom) {
    Map<MemberType, List<ClusterGroup>> result = {};
    for (var type in MemberType.values) {
      final filtered = items.where((e) => e.memberType == type).toList();
      result[type] = ClusterHelper.cluster(filtered, zoom);
    }
    return result;
  }
}
