import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@JsonEnum()
enum MessageType { CHAT, JOIN, LEAVE }

@freezed
class ChatMessage with _$ChatMessage {
  @JsonSerializable(explicitToJson: true)
  const factory ChatMessage({
    required int senderId,
    required String sender,
    required int chatroomId,
    required String content,
    required MessageType messageType,
    required DateTime createdAt,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}
