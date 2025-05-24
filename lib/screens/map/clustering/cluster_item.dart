import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';

enum JobType { family, volunteer, caregiver }

class ClusterItem {
  final String id;
  final LatLng position;
  final JobType jobType;
  final Map<String, dynamic> data;
  final Offset anchor;
  final Size iconSize;

  ClusterItem({
    required this.id,
    required this.position,
    required this.jobType,
    required this.data,
    this.anchor = const Offset(0.5, 1.0),
    this.iconSize = const Size(40, 60),
  });
}
