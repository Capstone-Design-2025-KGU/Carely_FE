// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SkillImpl _$$SkillImplFromJson(Map<String, dynamic> json) => _$SkillImpl(
  communication: $enumDecode(_$SkillLevelEnumMap, json['communication']),
  meal: $enumDecode(_$SkillLevelEnumMap, json['meal']),
  toilet: $enumDecode(_$SkillLevelEnumMap, json['toilet']),
  bath: $enumDecode(_$SkillLevelEnumMap, json['bath']),
  walk: $enumDecode(_$SkillLevelEnumMap, json['walk']),
);

Map<String, dynamic> _$$SkillImplToJson(_$SkillImpl instance) =>
    <String, dynamic>{
      'communication': _$SkillLevelEnumMap[instance.communication]!,
      'meal': _$SkillLevelEnumMap[instance.meal]!,
      'toilet': _$SkillLevelEnumMap[instance.toilet]!,
      'bath': _$SkillLevelEnumMap[instance.bath]!,
      'walk': _$SkillLevelEnumMap[instance.walk]!,
    };

const _$SkillLevelEnumMap = {
  SkillLevel.low: 'LOW',
  SkillLevel.middle: 'MIDDLE',
  SkillLevel.high: 'HIGH',
};
