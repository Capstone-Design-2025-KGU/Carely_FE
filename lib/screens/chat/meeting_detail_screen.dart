import 'package:carely/models/chat_message.dart';
import 'package:carely/providers/member_provider.dart';
import 'package:carely/providers/nearest_meeting_provider.dart';
import 'package:carely/services/chat/web_socket_service.dart';
import 'package:carely/services/meeting_service.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:carely/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeetingDetailScreen extends StatelessWidget {
  final String name;
  final String age;
  final String address;
  final String detailAddress;
  final String date;
  final String time;
  final String chore;
  final int meetingId;
  final int chatRoomId;
  final int senderId;
  final bool isAccepted;

  const MeetingDetailScreen({
    super.key,
    required this.name,
    required this.age,
    required this.address,
    required this.detailAddress,
    required this.date,
    required this.time,
    required this.chore,
    required this.meetingId,
    required this.chatRoomId,
    required this.senderId,
    required this.isAccepted,
  });

  @override
  Widget build(BuildContext context) {
    final memberProvider = context.watch<MemberProvider>();
    final currentUserId = memberProvider.member?.memberId;

    final isRequester = currentUserId != null && currentUserId == senderId;

    if (memberProvider.member == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFF3F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF3F2),
        elevation: 0,
        title: const Text(
          '요양보호 약속 확인',
          style: TextStyle(color: AppColors.gray900),
        ),
        iconTheme: const IconThemeData(color: AppColors.gray900),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  '요청자 정보',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                const SizedBox(height: 16),
                InfoRow(label: '이름', value: name),
                InfoRow(label: '나이', value: age),
                InfoRow(label: '주소', value: address),
                InfoRow(label: '상세 주소', value: detailAddress),
                const SizedBox(height: 24),
                const Text(
                  '요청한 일',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                const SizedBox(height: 16),
                InfoRow(label: '날짜', value: date),
                InfoRow(label: '시간', value: time),
                InfoRow(label: '주된 일', value: chore),
              ],
            ),
            if (!isRequester && !isAccepted)
              Column(
                children: [
                  DefaultButton(
                    content: '수락',
                    onPressed: () async {
                      await MeetingService.instance.respondMeeting(
                        meetingId: meetingId,
                        accept: true,
                      );

                      final systemMessage = ChatMessage(
                        senderId: senderId,
                        chatroomId: chatRoomId,
                        content: '약속이 수락되었습니다.',
                        messageType: MessageType.MEETING_ACCEPT,
                        meetingId: meetingId,
                        date: date,
                        time: time,
                        chore: chore,
                      );
                      WebSocketService.instance.sendMessage(systemMessage);
                      Provider.of<NearestMeetingProvider>(
                        context,
                        listen: false,
                      ).loadNearestMeeting();

                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () async {
                      await MeetingService.instance.respondMeeting(
                        meetingId: meetingId,
                        accept: false,
                      );
                      final systemMessage = ChatMessage(
                        senderId: senderId,
                        chatroomId: chatRoomId,
                        content: '약속이 거절되었습니다.',
                        messageType: MessageType.MEETING_CANCEL,
                        meetingId: meetingId,
                      );

                      WebSocketService.instance.sendMessage(systemMessage);
                      Provider.of<NearestMeetingProvider>(
                        context,
                        listen: false,
                      ).loadNearestMeeting();

                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size(
                        ScreenSize.width(context, 336),
                        ScreenSize.height(context, 52),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(color: Colors.red),
                      ),
                      foregroundColor: Colors.red,
                      backgroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: Text('취소'),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.gray400,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.gray900,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
