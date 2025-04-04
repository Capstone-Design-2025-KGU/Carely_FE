import 'package:flutter/material.dart';
import 'package:carely/models/member.dart';

class UserProvider with ChangeNotifier {
  Member? _currentUser;

  Member? get currentUser => _currentUser;

  void setUser(Member user) {
    _currentUser = user;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  bool get isLoggedIn => _currentUser != null;
}
