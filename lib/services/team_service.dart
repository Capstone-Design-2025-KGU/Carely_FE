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
}
