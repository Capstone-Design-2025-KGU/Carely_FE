import 'package:carely/models/memory.dart';
import 'package:carely/services/api_service.dart';
import 'package:carely/services/auth/token_storage_service.dart';
import 'package:carely/utils/logger_config.dart';

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
}
