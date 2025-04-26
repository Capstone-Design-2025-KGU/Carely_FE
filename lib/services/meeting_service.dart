import 'package:carely/models/chat_message.dart';
import 'package:carely/services/api_service.dart';
import 'package:carely/services/auth/token_storage_service.dart';
import 'package:carely/services/chat/web_socket_service.dart';
import 'package:carely/utils/logger_config.dart';

class MeetingService {
  MeetingService._();
  static final MeetingService instance = MeetingService._();

  Future<int?> createMeeting({
    required int opponentMemberId,
    required DateTime startTime,
    required DateTime endTime,
    required String chore,
  }) async {
    try {
      final token = await TokenStorageService.getToken();

      final response = await APIService.instance.request(
        '/meetings/new/$opponentMemberId',
        DioMethod.post,
        param: {
          'startTime': startTime.toIso8601String(),
          'endTime': endTime.toIso8601String(),
          'chore': chore,
        },
        token: token,
      );

      return response.data['meetingId'];
    } catch (e) {
      logger.e('약속 생성 실패: $e');
      return null;
    }
  }

  Future<void> respondMeeting({
    required int meetingId,
    required bool accept,
    required int chatRoomId,
    required int senderId,
  }) async {
    final response = await APIService.instance.request(
      '/meetings/$meetingId/${accept ? "accept" : "reject"}',
      DioMethod.post,
    );

    // ✅ 수락 or 거절 성공하면 WebSocket으로 알림 보내기
    final systemMessage = ChatMessage(
      senderId: senderId,
      chatroomId: chatRoomId,
      content: accept ? '약속이 수락되었습니다.' : '약속이 거절되었습니다.',
      messageType: MessageType.MEETING_ACCEPT,
    );

    WebSocketService.instance.sendMessage(systemMessage);
  }
}
