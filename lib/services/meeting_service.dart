import 'package:carely/services/api_service.dart';
import 'package:carely/services/auth/token_storage_service.dart';
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
  }) async {
    try {
      final token = await TokenStorageService.getToken();

      await APIService.instance.request(
        '/meetings/$meetingId',
        accept ? DioMethod.post : DioMethod.patch,
        token: token,
      );
    } catch (e) {
      logger.e('약속 수락/거절 실패: $e');
    }
  }

  static Future<void> rejectMeeting({
    required int meetingId,
    required String token,
  }) async {
    try {
      await APIService.instance.request(
        '/meetings/$meetingId',
        DioMethod.patch,
        token: token,
      );
    } catch (e) {
      logger.e('🛑 미팅 중단 실패: $e');
      rethrow;
    }
  }
}
