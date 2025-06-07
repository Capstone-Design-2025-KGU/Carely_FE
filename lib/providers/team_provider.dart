import 'package:flutter/material.dart';

class TeamProvider with ChangeNotifier {
  final Set<int> _joinedTeamIds = {};

  bool isJoined(int teamId) => _joinedTeamIds.contains(teamId);

  void markAsJoined(int teamId) {
    _joinedTeamIds.add(teamId);
    notifyListeners();
  }

  void unjoin(int teamId) {
    _joinedTeamIds.remove(teamId);
    notifyListeners();
  }
}
