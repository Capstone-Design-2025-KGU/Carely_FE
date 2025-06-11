import 'package:carely/utils/member_type.dart';
import 'package:carely/models/skill.dart';

class NeighborMember {
  final int memberId;
  final String name;
  final MemberType memberType;
  final double latitude;
  final double longitude;
  final int? withTime;
  final double distance;
  final Skill? skill;

  NeighborMember({
    required this.memberId,
    required this.name,
    required this.memberType,
    required this.latitude,
    required this.longitude,
    this.withTime,
    required this.distance,
    this.skill,
  });

  factory NeighborMember.fromJson(Map<String, dynamic> json) {
    try {
      return NeighborMember(
        memberId: json['memberId'] ?? 0,
        name: json['name'] ?? '',
        memberType: _parseMemberType(json['memberType'] ?? 'FAMILY'),
        latitude: (json['lat'] ?? json['latitude'] ?? 0.0).toDouble(),
        longitude: (json['lng'] ?? json['longitude'] ?? 0.0).toDouble(),
        withTime: json['withTime'],
        distance: (json['distance'] ?? 0.0).toDouble(),
        skill: json['skill'] != null ? Skill.fromJson(json['skill']) : null,
      );
    } catch (e) {
      throw ArgumentError('NeighborMember 파싱 실패: $e, 데이터: $json');
    }
  }

  static MemberType _parseMemberType(String type) {
    switch (type.toUpperCase()) {
      case 'FAMILY':
        return MemberType.family;
      case 'VOLUNTEER':
        return MemberType.volunteer;
      case 'CAREGIVER':
      case 'WORKER':
        return MemberType.caregiver;
      default:
        throw ArgumentError('Unknown member type: $type');
    }
  }
}
