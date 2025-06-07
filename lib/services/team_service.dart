import 'package:carely/models/post_outline.dart';
import 'package:carely/models/team.dart';
import 'package:carely/services/api_service.dart';
import 'package:carely/utils/logger_config.dart';

class TeamService {
  static Future<List<Team>> fetchNeighborTeams({required String token}) async {
    try {
      final response = await APIService.instance.request(
        '/teams/search-neighbor',
        DioMethod.get,
        token: token,
      );

      final List<dynamic> content = response.data['content'];
      return content.map((e) => Team.fromJson(e)).toList();
    } catch (e) {
      logger.e('🛑 이웃 그룹 목록 불러오기 실패: $e');
      rethrow;
    }
  }

  static Future<List<PostOutline>> fetchPosts({
    required int teamId,
    required String token,
  }) async {
    try {
      final response = await APIService.instance.request(
        '/teams/$teamId/posts',
        DioMethod.get,
        token: token,
      );

      final List<dynamic> data = response.data['content'];
      return data.map((e) => PostOutline.fromJson(e)).toList();
    } catch (e) {
      logger.e('🛑 게시글 목록 불러오기 실패: $e');
      rethrow;
    }
  }

  static Future<bool> joinTeam({
    required int teamId,
    required String token,
  }) async {
    final response = await APIService.instance.request(
      '/teams/$teamId/join',
      DioMethod.post,
      token: token,
    );

    return response.data == true;
  }

  static Future<List<Team>> fetchMyTeams({required String token}) async {
    final response = await APIService.instance.request(
      '/teams/',
      DioMethod.get,
      token: token,
    );

    final List<dynamic> data = response.data;
    return data.map((e) => Team.fromJson(e)).toList();
  }
}
