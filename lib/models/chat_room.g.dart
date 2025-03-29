// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatRoomImpl _$$ChatRoomImplFromJson(Map<String, dynamic> json) =>
    _$ChatRoomImpl(
      memberId: (json['memberId'] as num).toInt(),
      memberName: json['memberName'] as String,
      memberType: const MemberTypeConverter().fromJson(
        json['memberType'] as String,
      ),
      profileImage: json['profileImage'] as String,
      chatRoomId: (json['chatRoomId'] as num).toInt(),
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
      'memberType': const MemberTypeConverter().toJson(instance.memberType),
      'profileImage': instance.profileImage,
      'chatRoomId': instance.chatRoomId,
      'content': instance.content,
      'participantCount': instance.participantCount,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
