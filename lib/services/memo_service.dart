import 'package:carely/services/api_service.dart';
import 'package:carely/utils/logger_config.dart';

class MemoService {
  static Future<void> updateMemo({
    required int memberId,
    required String memoText,
    required String token,
  }) async {
    try {
      await APIService.aiInstance.request(
        '/memos/$memberId',
        DioMethod.put,
        param: {'original': memoText},
        token: token,
      );
    } catch (e) {
      logger.e('🛑 메모 저장 실패: $e');
      rethrow;
    }
  }
}
