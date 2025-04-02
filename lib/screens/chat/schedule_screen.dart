import 'package:carely/theme/colors.dart';
import 'package:carely/utils/member_color.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';

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
                  TextButton(onPressed: () {}, child: Text('캘린더 열기')),
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
