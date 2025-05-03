import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:carely/utils/skill_level.dart';

part 'skill.freezed.dart';
part 'skill.g.dart';

@freezed
class Skill with _$Skill {
  const factory Skill({
    required SkillLevel communication,
    required SkillLevel meal,
    required SkillLevel toilet,
    required SkillLevel bath,
    required SkillLevel walk,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}
