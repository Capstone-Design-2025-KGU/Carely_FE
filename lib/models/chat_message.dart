import 'package:carely/utils/flexible_date_time_list_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@JsonEnum()
enum MessageType {
  CHAT,
  JOIN,
  LEAVE,
  MEETING_REQUEST,
  MEETING_ACCEPT,
  MEETING_CANCEL,
}

@freezed
class ChatMessage with _$ChatMessage {
  @JsonSerializable(explicitToJson: true)
  const factory ChatMessage({
    required int senderId,
    required int chatroomId,
    required String content,
    required MessageType messageType,
    int? meetingId,

    String? date,
    String? time,
    String? chore,

    @FlexibleDateTimeConverter() DateTime? createdAt,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}
