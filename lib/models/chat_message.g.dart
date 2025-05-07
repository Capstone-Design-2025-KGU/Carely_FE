// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      senderId: (json['senderId'] as num).toInt(),
      chatroomId: (json['chatroomId'] as num).toInt(),
      content: json['content'] as String,
      messageType: $enumDecode(_$MessageTypeEnumMap, json['messageType']),
      meetingId: (json['meetingId'] as num?)?.toInt(),
      date: json['date'] as String?,
      time: json['time'] as String?,
      chore: json['chore'] as String?,
      createdAt: const FlexibleDateTimeConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'chatroomId': instance.chatroomId,
      'content': instance.content,
      'messageType': _$MessageTypeEnumMap[instance.messageType]!,
      'meetingId': instance.meetingId,
      'date': instance.date,
      'time': instance.time,
      'chore': instance.chore,
      'createdAt': const FlexibleDateTimeConverter().toJson(instance.createdAt),
    };

const _$MessageTypeEnumMap = {
  MessageType.CHAT: 'CHAT',
  MessageType.JOIN: 'JOIN',
  MessageType.LEAVE: 'LEAVE',
  MessageType.MEETING_REQUEST: 'MEETING_REQUEST',
  MessageType.MEETING_ACCEPT: 'MEETING_ACCEPT',
  MessageType.MEETING_CANCEL: 'MEETING_CANCEL',
};
