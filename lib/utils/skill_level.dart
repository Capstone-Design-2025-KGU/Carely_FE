import 'package:json_annotation/json_annotation.dart';

enum SkillLevel {
  @JsonValue('LOW')
  low,

  @JsonValue('MIDDLE')
  middle,

  @JsonValue('HIGH')
  high,
}
