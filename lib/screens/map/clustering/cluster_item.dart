import 'package:google_maps_flutter/google_maps_flutter.dart';

enum JobType { family, volunteer, caregiver }

class ClusterItem {
  final String id;
  final LatLng position;
  final JobType jobType;
  final Map<String, dynamic> data;

  ClusterItem({
    required this.id,
    required this.position,
    required this.jobType,
    required this.data,
  });
}
