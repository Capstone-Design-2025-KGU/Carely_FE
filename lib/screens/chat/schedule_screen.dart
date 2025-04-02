import 'package:carely/theme/colors.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: '만남 요청하기'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 16.0),
                Text('기본 정보'),
                SizedBox(height: 20.0),
                Text(
                  '이름',
                  style: TextStyle(
                    color: AppColors.gray400,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
