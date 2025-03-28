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
      profileImage: json['profileImage'] as String,
      chatroomId: (json['chatroomId'] as num).toInt(),
      content: json['content'] as String,
      participantCount: (json['participantCount'] as num).toInt(),
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
      'profileImage': instance.profileImage,
      'chatroomId': instance.chatroomId,
      'content': instance.content,
      'participantCount': instance.participantCount,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$MemberTypeEnumMap = {
  MemberType.family: 'family',
  MemberType.volunteer: 'volunteer',
  MemberType.caregiver: 'caregiver',
};
