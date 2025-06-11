import 'package:carely/models/memory.dart';
import 'package:carely/services/api_service.dart';
import 'package:carely/services/auth/token_storage_service.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:carely/models/other_memory.dart';

class MemoryService {
  static Future<List<Memory>> fetchMyMemories(int memberId) async {
    final token = await TokenStorageService.getToken();
    final response = await APIService.instance.request(
      '/memories/others?mid=$memberId',
      DioMethod.get,
      token: token,
    );

    logger.i('response.data type: ${response.data.runtimeType}');
    logger.i('response.data raw: ${response.data}');

    final List<dynamic> dataList = response.data;
    return dataList.map((json) => Memory.fromJson(json)).toList();
  }

  static Future<List<OtherMemory>> fetchOtherMemories(
    int targetMemberId,
  ) async {
    try {
      logger.i('🔍 함께한 추억 목록 API 호출 시작 - targetMemberId: $targetMemberId');

      final token = await TokenStorageService.getToken();
      if (token == null) {
        logger.e('❌ 토큰이 없습니다');
        return [];
      }

      logger.i('🔑 토큰 확인됨: ${token.substring(0, 20)}...');

      final response = await APIService.instance.request(
        '/memories/others?mid=$targetMemberId',
        DioMethod.get,
        token: token,
      );

      logger.i('📡 API 응답 받음: ${response.statusCode}');

      if (response.statusCode != 200) {
        logger.e('❌ API 응답 에러: ${response.statusCode} - ${response.data}');
        return [];
      }

      final data = response.data;
      logger.i('📊 응답 데이터 타입: ${data.runtimeType}');
      logger.i('📊 응답 데이터: $data');

      if (data is List) {
        logger.i('📋 리스트 데이터 확인: ${data.length}개 항목');
        if (data.isNotEmpty) {
          logger.i('📋 첫 번째 항목: ${data.first}');
        }

        final memories =
            data
                .map((e) {
                  try {
                    return OtherMemory.fromJson(e);
                  } catch (parseError) {
                    logger.e('❌ OtherMemory 파싱 실패: $parseError');
                    logger.e('❌ 파싱 실패한 데이터: $e');
                    return null;
                  }
                })
                .where((memory) => memory != null)
                .cast<OtherMemory>()
                .toList();

        logger.i('✅ 함께한 추억 목록 파싱 완료: ${memories.length}개');
        return memories;
      } else {
        logger.w('⚠️ 응답이 리스트가 아님: $data');
        return [];
      }
    } catch (e) {
      logger.e('❌ 함께한 추억 목록 API 호출 실패: $e');
      return [];
    }
  }
}
