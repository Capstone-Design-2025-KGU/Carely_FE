import 'package:carely/theme/colors.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:flutter/material.dart';

class GroupScreen extends StatefulWidget {
  static String id = 'group-screen';
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.mainPrimary,
          unselectedLabelColor: AppColors.gray400,
          indicatorColor: AppColors.mainPrimary,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          ),
          tabs: const [Tab(text: '내 모임'), Tab(text: '이웃 모임 둘러보기')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _EmptyGroupView(message: '아직 내 모임이 없어요!\n이웃 모임을 둘러보세요'),
          _EmptyGroupView(message: '이웃 모임이 없어요'),
        ],
      ),
    );
  }
}

class _EmptyGroupView extends StatelessWidget {
  final String message;

  const _EmptyGroupView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/no-chat-room.png',
            width: ScreenSize.width(context, 248.0),
          ),
          const SizedBox(height: 16.0),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.gray300,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
