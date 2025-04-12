import 'package:carely/providers/member_provider.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color _backgroundColorFor(MemberType type) {
    switch (type) {
      case MemberType.family:
        return AppColors.main50;
      case MemberType.volunteer:
        return AppColors.blue100;
      case MemberType.caregiver:
        return AppColors.green100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final member = context.watch<MemberProvider>().member;
    final userName = member?.name ?? '회원';

    // 기본 색상 지정 (혹시 null일 때 대비)
    final backgroundColor =
        member != null ? _backgroundColorFor(member.memberType) : Colors.white;

    return Scaffold(
      appBar: DefaultAppBar(title: '', isHome: true),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Text(
                  '안녕하세요 $userName님,\n내 주변 도움을 받아보세요!',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
