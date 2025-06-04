// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearest_meeting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NearestMeetingImpl _$$NearestMeetingImplFromJson(Map<String, dynamic> json) =>
    _$NearestMeetingImpl(
      meetingId: (json['meetingId'] as num).toInt(),
      sender: Member.fromJson(json['sender'] as Map<String, dynamic>),
      receiver: Member.fromJson(json['receiver'] as Map<String, dynamic>),
      startTime: DateTime.parse(json['startTime'] as String),
      memoId: (json['memoId'] as num).toInt(),
      walk: json['walk'] as String?,
      health: json['health'] as String?,
      medic: json['medic'] as String?,
      toilet: json['toilet'] as String?,
      comm: json['comm'] as String?,
      meal: json['meal'] as String?,
    );

Map<String, dynamic> _$$NearestMeetingImplToJson(
  _$NearestMeetingImpl instance,
) => <String, dynamic>{
  'meetingId': instance.meetingId,
  'sender': instance.sender,
  'receiver': instance.receiver,
  'startTime': instance.startTime.toIso8601String(),
  'memoId': instance.memoId,
  'walk': instance.walk,
  'health': instance.health,
  'medic': instance.medic,
  'toilet': instance.toilet,
  'comm': instance.comm,
  'meal': instance.meal,
};
