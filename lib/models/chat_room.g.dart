// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatRoomImpl _$$ChatRoomImplFromJson(Map<String, dynamic> json) =>
    _$ChatRoomImpl(
      memberId: (json['memberId'] as num).toInt(),
      memberName: json['memberName'] as String,
      memberType: $enumDecode(_$MemberTypeEnumMap, json['memberType']),
      chatroomId: (json['chatroomId'] as num).toInt(),
      content: json['content'] as String,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ChatRoomImplToJson(_$ChatRoomImpl instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'memberName': instance.memberName,
      'memberType': _$MemberTypeEnumMap[instance.memberType]!,
      'chatroomId': instance.chatroomId,
      'content': instance.content,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$MemberTypeEnumMap = {
  MemberType.family: 'family',
  MemberType.volunteer: 'volunteer',
  MemberType.caregiver: 'caregiver',
};
