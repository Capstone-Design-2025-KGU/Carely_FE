import 'package:carely/services/api_service.dart';
import 'package:carely/services/auth/token_storage_service.dart';
import 'package:carely/utils/logger_config.dart' show logger;

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  Future<String?> login(String username, String password) async {
    try {
      final response = await APIService.instance.request(
        '/login',
        DioMethod.post,
        param: {'username': username, 'password': password},
      );

      logger.i('로그인 응답: ${response.data}');

      final token = response.data['token'];
      await TokenStorageService.saveToken(token);
      return token;
    } catch (e) {
      logger.e('로그인 실패: $e');
      return null;
    }
  }
}
