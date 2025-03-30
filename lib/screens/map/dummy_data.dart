import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserData {
  final String id;
  final String name;
  final String jobType;
  final double distance;
  final String togetherTime;
  final Map<String, String> skills;
  final LatLng location;

  UserData({
    required this.id,
    required this.name,
    required this.jobType,
    required this.distance,
    required this.togetherTime,
    required this.skills,
    required this.location,
  });

  String get profileImagePath => 'assets/images/$jobType/profile/$id.png';
  String get skillImagePath => 'assets/images/$jobType/skills/$id.png';

  static String convertSkillLevel(String jobType, String skillLevel) {
    if (jobType == 'family') {
      switch (skillLevel) {
        case 'LOW':
          return '도움 필요';
        case 'MIDDLE':
          return '서투름';
        case 'HIGH':
          return '준수함';
        default:
          return '알 수 없음';
      }
    } else {
      switch (skillLevel) {
        case 'LOW':
          return '하급';
        case 'MIDDLE':
          return '중급';
        case 'HIGH':
          return '상급';
        default:
          return '알 수 없음';
      }
    }
  }
}

final List<UserData> dummyUsers = [
  UserData(
    id: '1',
    name: '이상덕',
    jobType: 'family',
    distance: 0.7,
    togetherTime: '3시간 20분',
    skills: {
      'communication': UserData.convertSkillLevel('family', 'HIGH'),
      'meal': UserData.convertSkillLevel('family', 'MIDDLE'),
      'toilet': UserData.convertSkillLevel('family', 'HIGH'),
      'bath': UserData.convertSkillLevel('family', 'LOW'),
      'walk': UserData.convertSkillLevel('family', 'MIDDLE'),
    },
    location: LatLng(37.5665, 126.9780),
  ),
  UserData(
    id: '2',
    name: '박지민',
    jobType: 'volunteer',
    distance: 1.2,
    togetherTime: '5시간 10분',
    skills: {
      'communication': UserData.convertSkillLevel('volunteer', 'HIGH'),
      'meal': UserData.convertSkillLevel('volunteer', 'LOW'),
      'toilet': UserData.convertSkillLevel('volunteer', 'MIDDLE'),
      'bath': UserData.convertSkillLevel('volunteer', 'HIGH'),
      'walk': UserData.convertSkillLevel('volunteer', 'MIDDLE'),
    },
    location: LatLng(37.5641, 126.9755),
  ),
  UserData(
    id: '3',
    name: '정수연',
    jobType: 'caregiver',
    distance: 0.5,
    togetherTime: '2시간 45분',
    skills: {
      'communication': UserData.convertSkillLevel('caregiver', 'MIDDLE'),
      'meal': UserData.convertSkillLevel('caregiver', 'LOW'),
      'toilet': UserData.convertSkillLevel('caregiver', 'HIGH'),
      'bath': UserData.convertSkillLevel('caregiver', 'MIDDLE'),
      'walk': UserData.convertSkillLevel('caregiver', 'HIGH'),
    },
    location: LatLng(37.5678, 126.9774),
  ),
  UserData(
    id: '4',
    name: '김민지',
    jobType: 'family',
    distance: 1.5,
    togetherTime: '4시간 50분',
    skills: {
      'communication': UserData.convertSkillLevel('family', 'MIDDLE'),
      'meal': UserData.convertSkillLevel('family', 'HIGH'),
      'toilet': UserData.convertSkillLevel('family', 'LOW'),
      'bath': UserData.convertSkillLevel('family', 'MIDDLE'),
      'walk': UserData.convertSkillLevel('family', 'HIGH'),
    },
    location: LatLng(37.5700, 126.9800),
  ),
  UserData(
    id: '5',
    name: '이준호',
    jobType: 'volunteer',
    distance: 2.0,
    togetherTime: '6시간 30분',
    skills: {
      'communication': UserData.convertSkillLevel('volunteer', 'MIDDLE'),
      'meal': UserData.convertSkillLevel('volunteer', 'HIGH'),
      'toilet': UserData.convertSkillLevel('volunteer', 'LOW'),
      'bath': UserData.convertSkillLevel('volunteer', 'MIDDLE'),
      'walk': UserData.convertSkillLevel('volunteer', 'HIGH'),
    },
    location: LatLng(37.5720, 126.9820),
  ),
  UserData(
    id: '6',
    name: '한서연',
    jobType: 'caregiver',
    distance: 1.8,
    togetherTime: '3시간 55분',
    skills: {
      'communication': UserData.convertSkillLevel('caregiver', 'HIGH'),
      'meal': UserData.convertSkillLevel('caregiver', 'MIDDLE'),
      'toilet': UserData.convertSkillLevel('caregiver', 'LOW'),
      'bath': UserData.convertSkillLevel('caregiver', 'HIGH'),
      'walk': UserData.convertSkillLevel('caregiver', 'MIDDLE'),
    },
    location: LatLng(37.5690, 126.9790),
  ),
  UserData(
    id: '7',
    name: '박영철',
    jobType: 'family',
    distance: 0.9,
    togetherTime: '2시간 10분',
    skills: {
      'communication': UserData.convertSkillLevel('family', 'LOW'),
      'meal': UserData.convertSkillLevel('family', 'MIDDLE'),
      'toilet': UserData.convertSkillLevel('family', 'MIDDLE'),
      'bath': UserData.convertSkillLevel('family', 'HIGH'),
      'walk': UserData.convertSkillLevel('family', 'LOW'),
    },
    location: LatLng(37.5650, 126.9770),
  ),
  UserData(
    id: '8',
    name: '최유진',
    jobType: 'volunteer',
    distance: 2.5,
    togetherTime: '7시간 15분',
    skills: {
      'communication': UserData.convertSkillLevel('volunteer', 'LOW'),
      'meal': UserData.convertSkillLevel('volunteer', 'MIDDLE'),
      'toilet': UserData.convertSkillLevel('volunteer', 'HIGH'),
      'bath': UserData.convertSkillLevel('volunteer', 'LOW'),
      'walk': UserData.convertSkillLevel('volunteer', 'MIDDLE'),
    },
    location: LatLng(37.5730, 126.9830),
  ),
];
