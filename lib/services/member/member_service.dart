import 'package:carely/models/member.dart';
import 'package:carely/services/api_service.dart';
import 'package:carely/utils/logger_config.dart';

class MemberService {
  MemberService._();
  static final MemberService instance = MemberService._();

  Future<Member?> fetchMyInfo(String token) async {
    try {
      final response = await APIService.instance.request(
        '/members/profile/my',
        DioMethod.get,
        token: token,
      );
      final data = response.data;
      return Member.fromJson(data);
    } catch (e) {
      logger.e('유저 정보 불러오기 실패: $e');
      return null;
    }
  }

  Future<bool> register(Member member) async {
    try {
      final response = await APIService.instance.request(
        '/members/new',
        DioMethod.post,
        param: member.toJson(),
      );
      return response.statusCode == 200;
    } catch (e) {
      logger.e('회원가입 API 오류: $e');
      return false;
    }
  }

  Future<Member?> fetchMemberById(int memberId, String token) async {
    try {
      final response = await APIService.instance.request(
        '/members/$memberId',
        DioMethod.get,
        token: token,
      );
      final data = response.data;

      // 필수 필드 확인
      if (data == null || data['memberId'] == null) {
        logger.e('받아온 데이터에 필수 필드가 없음.');
        return null;
      }

      return Member.fromJson(data);
    } catch (e) {
      logger.e('멤버 ID로 멤버 정보 불러오기 실패: $e');
      return null;
    }
  }
}
