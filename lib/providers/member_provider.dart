import 'package:carely/models/member.dart';
import 'package:flutter/material.dart';

class MemberProvider with ChangeNotifier {
  Member? _currentMember;

  Member? get currentMember => _currentMember;

  void setMember(Member member) {
    _currentMember = member;
    notifyListeners();
  }

  void clear() {
    _currentMember = null;
    notifyListeners();
  }
}
