// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemoImpl _$$MemoImplFromJson(Map<String, dynamic> json) => _$MemoImpl(
  meetingId: (json['meetingId'] as num).toInt(),
  receiver: Member.fromJson(json['receiver'] as Map<String, dynamic>),
  sender: Member.fromJson(json['sender'] as Map<String, dynamic>),
  startTime: DateTime.parse(json['startTime'] as String),
  memoId: (json['memoId'] as num).toInt(),
  walk: json['walk'] as String?,
  health: json['health'] as String?,
  medic: json['medic'] as String?,
  toilet: json['toilet'] as String?,
  comm: json['comm'] as String?,
  meal: json['meal'] as String?,
);

Map<String, dynamic> _$$MemoImplToJson(_$MemoImpl instance) =>
    <String, dynamic>{
      'meetingId': instance.meetingId,
      'receiver': instance.receiver.toJson(),
      'sender': instance.sender.toJson(),
      'startTime': instance.startTime.toIso8601String(),
      'memoId': instance.memoId,
      'walk': instance.walk,
      'health': instance.health,
      'medic': instance.medic,
      'toilet': instance.toilet,
      'comm': instance.comm,
      'meal': instance.meal,
    };
