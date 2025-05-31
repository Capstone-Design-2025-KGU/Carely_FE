import 'package:carely/models/nearest_meeting.dart';
import 'package:carely/services/nearest_meeting_service.dart';
import 'package:flutter/material.dart';

class NearestMeetingProvider with ChangeNotifier {
  NearestMeeting? _meeting;

  NearestMeeting? get meeting => _meeting;

  Future<void> loadNearestMeeting() async {
    _meeting = await NearestMeetingService.fetchNearestMeeting();
    notifyListeners();
  }

  void clear() {
    _meeting = null;
    notifyListeners();
  }
}
