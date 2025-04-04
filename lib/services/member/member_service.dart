import 'package:carely/models/member.dart';
import 'package:carely/services/api_service.dart';
import 'package:carely/utils/logger_config.dart';

Future<Member?> getMyInfo(String token) async {
  try {
    final response = await APIService.instance.request(
      '/members/profile/my',
      DioMethod.post,
      token: token,
    );
    return Member.fromJson(response.data);
  } catch (e) {
    logger.e('사용자 정보 불러오기 실패: $e');
    return null;
  }
}
