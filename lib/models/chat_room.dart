import 'package:carely/utils/member_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room.freezed.dart';
part 'chat_room.g.dart';

@freezed
class ChatRoom with _$ChatRoom {
  @JsonSerializable(explicitToJson: true)
  const factory ChatRoom({
    required int memberId,
    required String memberName,
    required MemberType memberType,
    required int chatroomId,
    required String content,
    DateTime? createdAt,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
}
