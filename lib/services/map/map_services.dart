import 'package:carely/services/api_service.dart';
import 'package:carely/models/map_member.dart';
import 'package:carely/models/neighbor_member.dart' hide MemberType;
import 'package:carely/models/address.dart';
import 'package:carely/models/skill.dart';
import 'package:carely/services/auth/token_storage_service.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/utils/skill_level.dart';

class MapServices {
  // 이웃 검색 (지도/리스트)
  static Future<List<NeighborMember>> fetchNeighbors() async {
    try {
      logger.i('🔍 이웃 목록 API 호출 시작');

      final token = await TokenStorageService.getToken();
      if (token == null) {
        logger.e('❌ 토큰이 없습니다');
        return [];
      }

      logger.i('🔑 토큰 확인됨: ${token.substring(0, 20)}...');

      final response = await APIService.instance.request(
        '/members/search-neighbor',
        DioMethod.get,
        token: token,
      );

      logger.i('📡 API 응답 받음: ${response.statusCode}');

      // 응답 상태 코드 확인
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

        final neighbors =
            data
                .map((e) {
                  try {
                    return NeighborMember.fromJson(e);
                  } catch (parseError) {
                    logger.e('❌ NeighborMember 파싱 실패: $parseError');
                    logger.e('❌ 파싱 실패한 데이터: $e');
                    logger.e('❌ 파싱 실패한 데이터 타입: ${e.runtimeType}');
                    logger.e(
                      '❌ 파싱 실패한 데이터 키들: ${e is Map ? e.keys.toList() : 'Map이 아님'}',
                    );
                    return null;
                  }
                })
                .where((neighbor) => neighbor != null)
                .cast<NeighborMember>()
                .toList();

        logger.i('✅ 이웃 목록 파싱 완료: ${neighbors.length}명');
        return neighbors;
      } else {
        logger.w('⚠️ 응답이 리스트가 아님: $data');
        return [];
      }
    } catch (e) {
      logger.e('❌ 이웃 목록 API 호출 실패: $e');
      return [];
    }
  }

  // 특정 멤버 상세 정보
  static Future<MapMember?> fetchMemberDetail(int memberId) async {
    try {
      final token = await TokenStorageService.getToken();
      if (token == null) {
        logger.e('❌ 토큰이 없습니다 - memberId: $memberId');
        return null;
      }

      final response = await APIService.instance.request(
        '/members/$memberId',
        DioMethod.get,
        token: token,
      );

      // 응답 상태 코드 확인
      if (response.statusCode != 200) {
        logger.e('❌ 멤버 API 응답 에러: ${response.statusCode} - ${response.data}');
        return null;
      }

      final data = response.data;
      logger.i('📊 멤버 상세 데이터: $data');

      if (data != null && data['memberId'] != null) {
        try {
          final member = MapMember.fromJson(data);
          logger.i('✅ 멤버 로드 성공 - memberId: $memberId, 이름: ${member.name}');
          return member;
        } catch (parseError) {
          logger.e(
            '❌ MapMember.fromJson 파싱 실패 - memberId: $memberId, 에러: $parseError',
          );
          logger.e('❌ 파싱 실패한 데이터: $data');

          // 개별 필드별로 파싱 시도
          try {
            logger.i('🔧 개별 필드 파싱 시도...');
            final member = MapMember(
              memberId: data['memberId'],
              username: data['username'] ?? '',
              name: data['name'] ?? '',
              birth: _parseBirth(data['birth']),
              age: data['age'] ?? 0,
              story: data['story'],
              memberType: _parseMemberType(data['memberType']),
              profileImage: data['profileImage'],
              distance: (data['distance'] ?? 0).toDouble(),
              withTime: data['withTime'] ?? 0,
              address:
                  data['address'] != null
                      ? Address.fromJson(data['address'])
                      : null,
              skill:
                  data['skill'] != null ? Skill.fromJson(data['skill']) : null,
            );
            logger.i('✅ 수동 파싱 성공 - memberId: $memberId');
            return member;
          } catch (manualParseError) {
            logger.e('❌ 수동 파싱도 실패: $manualParseError');
            return null;
          }
        }
      } else {
        logger.w('⚠️ 멤버 데이터 없음 - memberId: $memberId, data: $data');
        return null;
      }
    } catch (e) {
      logger.e('❌ 멤버 API 호출 실패 - memberId: $memberId, 에러: $e');
      return null;
    }
  }

  // 수동 파싱을 위한 헬퍼 메서드들
  static String _parseBirth(dynamic birthJson) {
    if (birthJson is List && birthJson.length >= 3) {
      final year = birthJson[0];
      final month = birthJson[1].toString().padLeft(2, '0');
      final day = birthJson[2].toString().padLeft(2, '0');
      return '$year-$month-$day';
    }
    return '';
  }

  static MemberType _parseMemberType(String type) {
    switch (type.toUpperCase()) {
      case 'FAMILY':
        return MemberType.family;
      case 'VOLUNTEER':
        return MemberType.volunteer;
      case 'CAREGIVER':
        return MemberType.caregiver;
      default:
        return MemberType.family;
    }
  }

  // 개인 정보
  static Future<MapMember?> fetchMyProfile() async {
    try {
      final token = await TokenStorageService.getToken();
      if (token == null) {
        logger.e('❌ 토큰이 없습니다');
        return null;
      }

      final response = await APIService.instance.request(
        '/members/profile/my',
        DioMethod.get,
        token: token,
      );

      // 응답 상태 코드 확인
      if (response.statusCode != 200) {
        logger.e(
          '❌ 내 프로필 API 응답 에러: ${response.statusCode} - ${response.data}',
        );
        return null;
      }

      final data = response.data;
      if (data != null && data['memberId'] != null) {
        return MapMember.fromJson(data);
      }
      return null;
    } catch (e) {
      logger.e('❌ 내 프로필 API 호출 실패: $e');
      return null;
    }
  }
}
