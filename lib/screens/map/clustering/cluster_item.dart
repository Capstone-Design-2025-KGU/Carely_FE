import 'dart:ui';

import 'package:carely/utils/member_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClusterItem {
  final String id;
  final LatLng position;
  final MemberType memberType;
  final Map<String, dynamic> data;
  final Offset anchor;
  final Size iconSize;

  ClusterItem({
    required this.id,
    required this.position,
    required this.memberType,
    required this.data,
    this.anchor = const Offset(0.5, 1.0),
    this.iconSize = const Size(40, 60),
  });
}
