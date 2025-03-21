import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';

enum MessageType { CHAT, JOIN, LEAVE }

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required int senderId,
    required String sender,
    required int chatroomId,
    required String content,
    required MessageType messageType,
    required DateTime createdAt,
  }) = _ChatMessage;
}
