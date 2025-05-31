import 'package:carely/models/nearest_meeting.dart';
import 'package:carely/services/auth/token_storage_service.dart';
import 'package:carely/services/api_service.dart';
import 'package:carely/utils/logger_config.dart';

class NearestMeetingService {
  static Future<NearestMeeting?> fetchNearestMeeting() async {
    final token = await TokenStorageService.getToken();
    if (token == null) return null;

    try {
      final response = await APIService.instance.request(
        '/meetings/nearest',
        DioMethod.get,
        token: token,
      );

      return NearestMeeting.fromJson(response.data);
    } catch (e, stack) {
      logger.i('가장 임박한 미팅 요청 실패: $e\n$stack');
      return null;
    }
  }
}
