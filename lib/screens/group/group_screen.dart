import 'package:carely/models/team.dart';
import 'package:carely/screens/group/group_detail_screen.dart';
import 'package:carely/services/auth/token_storage_service.dart';
import 'package:carely/services/team_service.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupScreen extends StatefulWidget {
  static String id = 'group-screen';
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  late Future<Map<String, List<Team>>> _groupDataFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _groupDataFuture = _fetchGroupedTeams();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<Map<String, List<Team>>> _fetchGroupedTeams() async {
    final token = await TokenStorageService.getToken();

    final myTeams = await TeamService.fetchMyTeams(token: token!);
    final neighborTeams = await TeamService.fetchNeighborTeams(token: token);

    final myTeamIds = myTeams.map((t) => t.teamId).toSet();

    final filteredNeighborTeams =
        neighborTeams
            .where((team) => !myTeamIds.contains(team.teamId))
            .toList();

    return {'my': myTeams, 'neighbor': filteredNeighborTeams};
  }

  Widget _buildTeamListView(List<Team> teams, {required bool isJoined}) {
    if (teams.isEmpty) {
      return _EmptyGroupView(
        message: isJoined ? '아직 내 모임이 없어요!\n이웃 모임을 둘러보세요' : '이웃 모임이 없어요',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      itemCount: teams.length,
      itemBuilder: (context, index) {
        final team = teams[index];
        return GroupCard(
          teamId: team.teamId,
          title: team.teamName,
          location:
              '${team.address.province} ${team.address.city} ${team.address.district}',
          recentUpdate: 0,
          imagePath: '${index % 4 + 1}',
          memberCount: team.memberCount,
          isJoined: isJoined,
        );
      },
    );
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
      body: FutureBuilder<Map<String, List<Team>>>(
        future: _groupDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('모임 데이터를 불러오지 못했어요.'));
          }

          final myTeams = snapshot.data!['my']!;
          final neighborTeams = snapshot.data!['neighbor']!;

          return TabBarView(
            controller: _tabController,
            children: [
              _buildTeamListView(myTeams, isJoined: true),
              _buildTeamListView(neighborTeams, isJoined: false),
            ],
          );
        },
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final int teamId;
  final String title;
  final String location;
  final int recentUpdate;
  final String imagePath;
  final int memberCount;
  final bool isJoined;

  const GroupCard({
    super.key,
    required this.title,
    required this.location,
    required this.recentUpdate,
    required this.imagePath,
    required this.memberCount,
    required this.teamId,
    required this.isJoined,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => GroupDetailScreen(
                    teamId: teamId,
                    title: title,
                    location: location,
                    recentUpdate: recentUpdate,
                    imagePath: imagePath,
                    memberCount: memberCount,
                    isJoined: isJoined,
                  ),
            ),
          ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/group/$imagePath.png',
                          width: 68.0,
                          height: 68.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: AppColors.gray800,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            location,
                            style: const TextStyle(
                              color: AppColors.gray600,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.newspaper,
                                size: 16.0,
                                color: AppColors.mainPrimary,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                '$recentUpdate시간 전 새로운 소식',
                                style: const TextStyle(
                                  color: AppColors.mainPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  GroupMemberNumberCard(count: memberCount),
                ],
              ),
            ),
          ),
          const Divider(color: AppColors.gray50),
        ],
      ),
    );
  }
}

class GroupMemberNumberCard extends StatelessWidget {
  final int count;

  const GroupMemberNumberCard({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: AppColors.gray25,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          const FaIcon(
            FontAwesomeIcons.userGroup,
            size: 16.0,
            color: AppColors.mainPrimary,
          ),
          const SizedBox(width: 4.0),
          Text(
            '$count명',
            style: const TextStyle(
              color: AppColors.mainPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
            ),
          ),
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
