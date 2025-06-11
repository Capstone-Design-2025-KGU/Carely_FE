// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemoryImpl _$$MemoryImplFromJson(Map<String, dynamic> json) => _$MemoryImpl(
  memoryId: (json['memoryId'] as num).toInt(),
  oppoName: json['oppoName'] as String,
  memberType: const MemberTypeConverter().fromJson(
    json['memberType'] as String,
  ),
  oppoMemo: json['oppoMemo'] as String?,
);

Map<String, dynamic> _$$MemoryImplToJson(_$MemoryImpl instance) =>
    <String, dynamic>{
      'memoryId': instance.memoryId,
      'oppoName': instance.oppoName,
      'memberType': const MemberTypeConverter().toJson(instance.memberType),
      'oppoMemo': instance.oppoMemo,
    };
