import 'package:carely/theme/colors.dart';
import 'package:carely/utils/member_color.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final MemberType testMemberType = MemberType.family; // 여기서 타입 바꿔가며 테스트 가능
  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  String? selectedMainWork;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(testMemberType),
      appBar: DefaultAppBar(
        title: '만남 요청하기',
        color: getBackgroundColor(testMemberType),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 16.0),
                  Text(
                    '기본 정보',
                    style: TextStyle(
                      color: AppColors.gray800,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  InfoWidget(label: '이름', value: '김진철'),
                  InfoWidget(label: '나이', value: '33세'),
                  InfoWidget(label: '전화번호', value: '010-1111-1111'),
                  InfoWidget(label: '주소', value: '경기도 용인시 수지구'),
                  SizedBox(height: 20.0),
                  Text(
                    '요청할 일',
                    style: TextStyle(
                      color: AppColors.gray800,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // 날짜 선택 필드
                  InputSelectField(
                    label: '날짜',
                    displayText:
                        selectedDate == null
                            ? '날짜를 선택하세요'
                            : '${selectedDate!.year}년 ${selectedDate!.month}월 ${selectedDate!.day}일',
                    onTap: () async {
                      final date = await showCalendarModal(
                        context,
                        getHighlightColor(testMemberType),
                      );
                      if (date != null) {
                        setState(() {
                          selectedDate = date;
                        });
                      }
                    },
                  ),

                  // 시간 선택 필드
                  InputSelectField(
                    label: '시간',
                    displayText:
                        selectedStartTime == null || selectedEndTime == null
                            ? '시간을 선택하세요'
                            : '${_getDurationText(selectedStartTime!, selectedEndTime!)} / ${_formatTimeOfDay(selectedStartTime!)} 시작',
                    onTap: () async {
                      final start = await showCustomTimePickerDialog(
                        context,
                        '시작 시간',
                        getHighlightColor(testMemberType),
                      );
                      if (start != null) {
                        final end = await showCustomTimePickerDialog(
                          context,
                          '종료 시간',
                          getHighlightColor(testMemberType),
                        );
                        setState(() {
                          selectedStartTime = start;
                          selectedEndTime = end;
                        });
                      }
                    },
                  ),

                  InputSelectField(
                    label: '주된 일',
                    displayText: selectedMainWork ?? '주된 일을 선택하세요',
                    onTap: () async {
                      final result = await showMainWorkSelectModal(context);
                      if (result != null) {
                        setState(() {
                          selectedMainWork = result;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputSelectField extends StatelessWidget {
  final String label;
  final String displayText;
  final VoidCallback onTap;

  const InputSelectField({
    super.key,
    required this.label,
    required this.displayText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: AppColors.gray500,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            hintText: '선택해주세요',
            hintStyle: TextStyle(color: AppColors.gray300, fontSize: 16.0),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.gray200),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.gray600),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                displayText,
                style: TextStyle(color: AppColors.gray800, fontSize: 16.0),
              ),
              FaIcon(
                FontAwesomeIcons.angleDown,
                size: 16.0,
                color: AppColors.gray300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<TimeOfDay?> showCustomTimePickerDialog(
  BuildContext context,
  String title,
  Color color,
) {
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime tempTime = DateTime.now();

  return showModalBottomSheet<TimeOfDay>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.gray800,
              ),
            ),
            const SizedBox(height: 16),
            TimePickerSpinner(
              is24HourMode: false,
              normalTextStyle: TextStyle(
                fontSize: 18,
                color: AppColors.gray400,
              ),
              highlightedTextStyle: TextStyle(
                fontSize: 24,
                color: color,
                fontWeight: FontWeight.bold,
              ),
              spacing: 50,
              itemHeight: 60,
              isForce2Digits: true,
              onTimeChange: (time) {
                tempTime = time;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  TimeOfDay(hour: tempTime.hour, minute: tempTime.minute),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '확인',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class InfoWidget extends StatelessWidget {
  final String label;
  final String value;
  final double labelWidth;

  const InfoWidget({
    super.key,
    required this.label,
    required this.value,
    this.labelWidth = 80.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: labelWidth,
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.gray400,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(width: 32.0),
          Text(
            value,
            style: TextStyle(
              color: AppColors.gray800,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

Future<DateTime?> showCalendarModal(BuildContext context, Color color) {
  DateTime selectedDate = DateTime.now();

  return showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 24,
                  bottom: 32,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TableCalendar(
                      locale: 'ko_KR',
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: selectedDate,
                      selectedDayPredicate:
                          (day) => isSameDay(selectedDate, day),
                      onDaySelected: (selected, focused) {
                        setState(() {
                          selectedDate = selected;
                        });
                      },
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.gray800,
                          height: 1.2,
                        ),
                        weekendStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.mainPrimary,
                          height: 1.2,
                        ),
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          color: AppColors.gray800,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, selectedDate);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        '확인',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

Future<String?> showMainWorkSelectModal(BuildContext context) {
  final options = [
    {'label': '요양 보호', 'emoji': '👵🏻'},
    {'label': '말벗 도움', 'emoji': '🗣️'},
    {'label': '재능 봉사', 'emoji': '🎤'},
    {'label': '기타', 'emoji': '🧹'},
  ];

  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '주된 일을 선택하세요',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray800,
                ),
              ),
              const SizedBox(height: 20),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: options.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index) {
                  final item = options[index];
                  return GestureDetector(
                    onTap: () => Navigator.pop(context, item['label']),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.main50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.gray200),
                      ),
                      child: Center(
                        child: Text(
                          '${item['emoji']} ${item['label']}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.gray800,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  '닫기',
                  style: TextStyle(
                    color: AppColors.gray800,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

String _getDurationText(TimeOfDay start, TimeOfDay end) {
  final startMin = start.hour * 60 + start.minute;
  final endMin = end.hour * 60 + end.minute;
  int duration = endMin - startMin;
  if (duration < 0) duration += 1440; // 다음날

  final h = duration ~/ 60;
  final m = duration % 60;
  return '$h시간${m > 0 ? ' $m분' : ''} 동안';
}

String _formatTimeOfDay(TimeOfDay time) {
  final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
  final minute = time.minute.toString().padLeft(2, '0');
  final period = time.period == DayPeriod.am ? '오전' : '오후';
  return '$period $hour시 $minute분';
}
