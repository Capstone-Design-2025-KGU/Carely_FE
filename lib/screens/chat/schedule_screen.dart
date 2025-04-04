import 'package:carely/theme/colors.dart';
import 'package:carely/utils/member_color.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final MemberType testMemberType = MemberType.family; // 여기서 타입 바꿔가며 테스트 가능

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
                  SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () async {
                      final date = await showCalendarModal(
                        context,
                        getHighlightColor(testMemberType),
                      );
                      if (date != null) {
                        final startTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                timePickerTheme: TimePickerThemeData(
                                  backgroundColor: Colors.white,
                                  hourMinuteTextColor: AppColors.gray800,
                                  dayPeriodTextColor: AppColors.gray800,

                                  dayPeriodColor: AppColors.gray100,
                                  entryModeIconColor: getHighlightColor(
                                    testMemberType,
                                  ),
                                  dialHandColor: getHighlightColor(
                                    testMemberType,
                                  ),
                                  dialBackgroundColor: AppColors.gray50,
                                  dialTextColor: AppColors.gray600,

                                  hourMinuteColor: AppColors.gray100,
                                  helpTextStyle: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.gray600,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                colorScheme: ColorScheme.light(
                                  primary: getHighlightColor(
                                    testMemberType,
                                  ), // ← 가장 핵심 색상
                                  onPrimary: Colors.white,
                                  onSurface: AppColors.gray800,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (startTime != null) {
                          final endTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  timePickerTheme: TimePickerThemeData(
                                    backgroundColor: Colors.white,
                                    hourMinuteTextColor: AppColors.gray800,
                                    dayPeriodTextColor: AppColors.gray800,

                                    dayPeriodColor: AppColors.gray100,
                                    entryModeIconColor: getHighlightColor(
                                      testMemberType,
                                    ),
                                    dialHandColor: getHighlightColor(
                                      testMemberType,
                                    ),
                                    dialBackgroundColor: AppColors.gray50,
                                    dialTextColor: AppColors.gray600,

                                    hourMinuteColor: AppColors.gray100,

                                    helpTextStyle: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.gray600,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  colorScheme: ColorScheme.light(
                                    primary: getHighlightColor(
                                      testMemberType,
                                    ), // ← 가장 핵심 색상
                                    onPrimary: Colors.white,
                                    onSurface: AppColors.gray800,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (endTime != null) {
                            final startDateTime = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              startTime.hour,
                              startTime.minute,
                            );

                            final endDateTime = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              endTime.hour,
                              endTime.minute,
                            );

                            // TODO: 여기에 상태 저장 또는 출력 등 필요한 로직 넣으면 됨
                            print('📅 날짜: $date');
                            print('🕒 시작 시간: $startDateTime');
                            print('🕓 종료 시간: $endDateTime');
                          }
                        }
                      }
                    },
                    child: Text('캘린더 열기'),
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
