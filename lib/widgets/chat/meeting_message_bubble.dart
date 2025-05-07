import 'package:carely/models/chat_message.dart';
import 'package:carely/models/member.dart';
import 'package:carely/providers/member_provider.dart';
import 'package:carely/screens/chat/meeting_detail_screen.dart';
import 'package:carely/services/auth/token_storage_service.dart';
import 'package:carely/services/meeting_service.dart';
import 'package:carely/services/member/member_service.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/utils/member_color.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MeetingMessageBubble extends StatefulWidget {
  final ChatMessage message;
  final DateTime? timeStamp;
  final bool isMine;
  final MemberType senderType;

  const MeetingMessageBubble({
    super.key,
    required this.message,
    this.timeStamp,
    required this.isMine,
    required this.senderType,
  });

  @override
  State<MeetingMessageBubble> createState() => _MeetingMessageBubbleState();
}

class _MeetingMessageBubbleState extends State<MeetingMessageBubble> {
  Member? sender;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final bubble = Container(
      constraints: BoxConstraints(maxWidth: ScreenSize.width(context, 220.0)),
      decoration: BoxDecoration(
        color: getHighlightColor(widget.senderType),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '약속 요청을 보냈어요!',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              widget.message.content ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12.0),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  final token = await TokenStorageService.getToken();

                  final fetchedMember = await MemberService.instance
                      .fetchMemberById(widget.message.senderId, token!);

                  if (fetchedMember == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('보낸 사람 정보를 불러오지 못했습니다.')),
                    );
                    return;
                  }

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (_) => MeetingDetailScreen(
                            name: fetchedMember.name,
                            age: calculateAge(fetchedMember.birth).toString(),
                            address:
                                '${fetchedMember.address.province} ${fetchedMember.address.city} ${fetchedMember.address.district}',
                            detailAddress: fetchedMember.address.details ?? '',
                            date: extractDateFromContent(
                              widget.message.content ?? '',
                            ),
                            time: extractTimeFromContent(
                              widget.message.content ?? '',
                            ),
                            chore: widget.message.chore ?? '주된 일 정보가 없습니다.',
                            meetingId: widget.message.meetingId!,
                            chatRoomId: widget.message.chatroomId,
                            senderId: widget.message.senderId,
                            isAccepted:
                                widget.message.messageType ==
                                MessageType.MEETING_ACCEPT,
                          ),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  '자세히 보기',
                  style: TextStyle(
                    color: getHighlightColor(widget.senderType),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     TextButton(
            //       onPressed: () => _respondMeeting(context, true),
            //       child: Text('수락', style: TextStyle(color: Colors.green)),
            //     ),
            //     TextButton(
            //       onPressed: () => _respondMeeting(context, false),
            //       child: Text('거절', style: TextStyle(color: Colors.red)),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );

    final formattedTime =
        widget.timeStamp != null
            ? DateFormat('HH:mm').format(widget.timeStamp!)
            : '';
    final time = Text(
      formattedTime,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.gray600,
        fontSize: 12.0,
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment:
            widget.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children:
            widget.isMine
                ? [time, SizedBox(width: 6.0), bubble]
                : [bubble, SizedBox(width: 6.0), time],
      ),
    );
  }

  void _respondMeeting(BuildContext context, bool isAccepted) async {
    try {
      if (widget.message.meetingId == null) {
        throw Exception('Meeting ID가 없습니다.');
      }
      final memberProvider = Provider.of<MemberProvider>(
        context,
        listen: false,
      );
      final currentMember = memberProvider.member;
      if (currentMember == null) return;

      await MeetingService.instance.respondMeeting(
        meetingId: widget.message.meetingId!,
        accept: isAccepted,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isAccepted ? '약속 수락 완료' : '약속 거절 완료')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('에러 발생: $e')));
    }
  }
}

int calculateAge(String birth) {
  final parts = birth.split('-');
  final year = int.parse(parts[0]);
  final now = DateTime.now();
  return now.year - year;
}

String extractDateFromContent(String content) {
  // 예: "장소 : 서울 강남구\n시간 : 2025년 5월 1일 (목) 13:00 - 15:00"
  final regex = RegExp(r'(\d{4})년 (\d{1,2})월 (\d{1,2})일');
  final match = regex.firstMatch(content);
  if (match != null) {
    return '${match.group(1)}-${match.group(2)!.padLeft(2, '0')}-${match.group(3)!.padLeft(2, '0')}';
  }
  return '';
}

String extractTimeFromContent(String content) {
  final regex = RegExp(r'(\d{1,2}):(\d{2}) - (\d{1,2}):(\d{2})');
  final match = regex.firstMatch(content);
  if (match != null) {
    return '${match.group(1)}:${match.group(2)} ~ ${match.group(3)}:${match.group(4)}';
  }
  return '';
}
