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
      createdAt: const FlexibleDateTimeConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'chatroomId': instance.chatroomId,
      'content': instance.content,
      'messageType': _$MessageTypeEnumMap[instance.messageType]!,
      'createdAt': const FlexibleDateTimeConverter().toJson(instance.createdAt),
    };

const _$MessageTypeEnumMap = {
  MessageType.CHAT: 'CHAT',
  MessageType.JOIN: 'JOIN',
  MessageType.LEAVE: 'LEAVE',
};
