// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'res_memo_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResMemoDTOImpl _$$ResMemoDTOImplFromJson(Map<String, dynamic> json) =>
    _$ResMemoDTOImpl(
      memoId: (json['memoId'] as num).toInt(),
      walk: json['walk'] as String?,
      health: json['health'] as String?,
      medic: json['medic'] as String?,
      meal: json['meal'] as String?,
      toilet: json['toilet'] as String?,
      comm: json['comm'] as String?,
    );

Map<String, dynamic> _$$ResMemoDTOImplToJson(_$ResMemoDTOImpl instance) =>
    <String, dynamic>{
      'memoId': instance.memoId,
      'walk': instance.walk,
      'health': instance.health,
      'medic': instance.medic,
      'meal': instance.meal,
      'toilet': instance.toilet,
      'comm': instance.comm,
    };
