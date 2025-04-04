import 'package:carely/services/api_service.dart';
import 'package:carely/utils/logger_config.dart' show logger;

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  Future<String?> login(String username, String password) async {
    try {
      final response = await APIService.instance.request(
        '/auth/login',
        DioMethod.post,
        param: {'username': username, 'password': password},
      );

      final token = response.data['token'];
      return token;
    } catch (e) {
      logger.e('로그인 실패: $e');
      return null;
    }
  }
}
