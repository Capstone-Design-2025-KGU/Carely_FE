import 'package:flutter/material.dart';
import 'package:carely/models/member.dart';
import 'package:carely/models/skill.dart';
import 'package:carely/models/address.dart';
import 'package:carely/utils/member_type.dart';

class MemberProvider with ChangeNotifier {
  Member? _member;

  Member? get member => _member;

  void setMember(Member member) {
    _member = member;
    notifyListeners();
  }

  void updatePartial({
    String? username,
    String? password,
    String? name,
    String? phoneNumber,
    String? birth,
    String? story,
    MemberType? memberType,
    bool? isVisible,
    Address? address,
    Skill? skill,
  }) {
    if (_member == null) return;

    _member = _member!.copyWith(
      username: username ?? _member!.username,
      name: name ?? _member!.name,
      phoneNumber: phoneNumber ?? _member!.phoneNumber,
      birth: birth ?? _member!.birth,
      story: story ?? _member!.story,
      memberType: memberType ?? _member!.memberType,
      isVisible: isVisible ?? _member!.isVisible,
      address: address ?? _member!.address,
      skill: skill ?? _member!.skill,
    );
    notifyListeners();
  }

  void clear() {
    _member = null;
    notifyListeners();
  }

  void setMemberType(MemberType type) {
    if (_member != null) {
      _member = _member!.copyWith(memberType: type);
      notifyListeners();
    }
  }
}
