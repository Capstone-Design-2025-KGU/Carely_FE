import 'package:carely/utils/member_type.dart';

class FilterUtils {
  /// 필터 토글
  static void toggleFilter(Set<MemberType> filters, MemberType filter) {
    if (filters.contains(filter)) {
      filters.remove(filter);
    } else {
      filters.add(filter);
    }
  }

  /// String을 MemberType으로 변환
  static MemberType? getMemberTypeFromString(String typeString) {
    switch (typeString) {
      case 'family':
        return MemberType.family;
      case 'volunteer':
        return MemberType.volunteer;
      case 'caregiver':
        return MemberType.caregiver;
      default:
        return null;
    }
  }

  /// 필터링 적용 (검색어와 유형 필터 모두 적용)
  static List<T> applyFilters<T>({
    required List<T> items,
    required String searchText,
    required Set<MemberType> typeFilters,
    required String Function(T) nameSelector,
    required MemberType? Function(T) typeSelector,
  }) {
    List<T> filtered = items;

    // 검색어 필터링
    if (searchText.isNotEmpty) {
      filtered =
          filtered
              .where(
                (item) => nameSelector(
                  item,
                ).toLowerCase().contains(searchText.toLowerCase()),
              )
              .toList();
    }

    // 유형 필터링
    if (typeFilters.isNotEmpty) {
      filtered =
          filtered
              .where((item) => typeFilters.contains(typeSelector(item)))
              .toList();
    }

    return filtered;
  }
}
