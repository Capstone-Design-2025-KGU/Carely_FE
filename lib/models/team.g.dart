// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamImpl _$$TeamImplFromJson(Map<String, dynamic> json) => _$TeamImpl(
  teamId: (json['teamId'] as num).toInt(),
  teamName: json['teamName'] as String,
  address: Address.fromJson(json['address'] as Map<String, dynamic>),
  story: json['story'] as String,
  memberCount: (json['memberCount'] as num).toInt(),
);

Map<String, dynamic> _$$TeamImplToJson(_$TeamImpl instance) =>
    <String, dynamic>{
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'address': instance.address,
      'story': instance.story,
      'memberCount': instance.memberCount,
    };
