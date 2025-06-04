import 'package:carely/models/res_memo_dto.dart';
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

  static Future<ResMemoDTO?> getMemoSummary({
    required int memberId,
    required String token,
  }) async {
    try {
      final response = await APIService.instance.request(
        '/memos/$memberId',
        DioMethod.get,
        token: token,
      );

      return ResMemoDTO.fromJson(response.data);
    } catch (e) {
      logger.e('🛑 메모 요약 불러오기 실패: $e');
      return null;
    }
  }
}
