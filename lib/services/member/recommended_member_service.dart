import 'dart:convert';
import 'package:carely/utils/logger_config.dart';
import 'package:dio/dio.dart';
import 'package:carely/models/recommended_member.dart';
import 'package:carely/services/api_service.dart';

class RecommendedMemberService {
  static Future<List<RecommendedMember>> fetchRecommendedMembers(
    String token,
  ) async {
    try {
      final response = await APIService.instance.request(
        '/members/recommend',
        DioMethod.get,
        token: token,
      );

      final content = response.data['content'] as List<dynamic>;
      return content.map((e) => RecommendedMember.fromJson(e)).toList();
    } catch (e, stack) {
      logger.i('추천 이웃 요청 실패: $e\n$stack');
      rethrow;
    }
  }
}
