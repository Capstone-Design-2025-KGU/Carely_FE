import 'dart:ui';

import 'package:carely/theme/colors.dart';
import 'package:carely/utils/member_type.dart';

Color getBackgroundColor(MemberType type) {
  switch (type) {
    case MemberType.family:
      return AppColors.main50;
    case MemberType.volunteer:
      return AppColors.blue100;
    case MemberType.caregiver:
      return AppColors.green100;
  }
}
