import 'package:carely/models/post_outline.dart';
import 'package:carely/providers/team_provider.dart';
import 'package:carely/services/auth/token_storage_service.dart';
import 'package:carely/services/team_service.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:carely/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class GroupDetailScreen extends StatefulWidget {
  final int teamId;
  final String title;
  final String location;
  final String story;
  final int recentUpdate;
  final String imagePath;
  final int memberCount;
  final bool isJoined;

  const GroupDetailScreen({
    super.key,
    required this.title,
    required this.location,
    required this.recentUpdate,
    required this.imagePath,
    required this.memberCount,
    required this.teamId,
    required this.isJoined,
    required this.story,
  });

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  late Future<List<PostOutline>> _postFuture;

  @override
  void initState() {
    super.initState();
    _postFuture = _fetchPosts();
  }

  Future<List<PostOutline>> _fetchPosts() async {
    final token = await TokenStorageService.getToken();
    return TeamService.fetchPosts(teamId: widget.teamId, token: token!);
  }

  Future<void> _joinTeam() async {
    final token = await TokenStorageService.getToken();
    final success = await TeamService.joinTeam(
      teamId: widget.teamId,
      token: token!,
    );
    if (success) {
      Provider.of<TeamProvider>(
        context,
        listen: false,
      ).markAsJoined(widget.teamId);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('모임에 가입했어요!')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('가입에 실패했어요.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isJoined = Provider.of<TeamProvider>(context).isJoined(widget.teamId);

    return Scaffold(
      appBar: DefaultAppBar(title: widget.title),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GroupCover(
              imagePath: widget.imagePath,
              title: widget.title,
              location: widget.location,
              memberCount: widget.memberCount,
            ),
            SizedBox(height: 36.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    '그룹 소개',
                    style: TextStyle(
                      color: AppColors.gray800,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    widget.story,
                    style: TextStyle(
                      color: AppColors.gray600,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '이웃 소식',
                        style: TextStyle(
                          color: AppColors.gray800,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        '더보기',
                        style: TextStyle(
                          color: AppColors.gray600,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                FutureBuilder<List<PostOutline>>(
                  future: _postFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.data!.isEmpty) {
                      return const Center(child: Text('게시글이 없습니다.'));
                    }

                    final posts = snapshot.data!;
                    return Column(
                      children:
                          posts.map((post) {
                            return NeighborNewsCard(
                              imageIndex: '1', // 임시 프로필
                              title: post.title,
                              content: '${post.writer.name}님의 게시글',
                              commentCount: post.commentCount,
                            );
                          }).toList(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          widget.isJoined
              ? null
              : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: DefaultButton(
                  content: '모임 가입하기',
                  onPressed: () => _joinTeam().then((_) {}),
                ),
              ),
    );
  }
}

class NeighborNewsCard extends StatelessWidget {
  final String imageIndex;
  final String title;
  final String content;
  final int commentCount;

  const NeighborNewsCard({
    super.key,
    required this.imageIndex,
    required this.title,
    required this.content,
    required this.commentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Container(
            width: ScreenSize.width(context, 334.0),
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/family/profile/$imageIndex.png',
                  width: 68.0,
                  height: 68.0,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16.0),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: AppColors.gray800,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        content,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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
                            FontAwesomeIcons.solidMessage,
                            size: 16.0,
                            color: AppColors.mainPrimary,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            '댓글 $commentCount개',
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
                ),
              ],
            ),
          ),
        ),
        Divider(color: AppColors.gray50),
      ],
    );
  }
}

class GroupCover extends StatelessWidget {
  const GroupCover({
    super.key,
    required this.imagePath,
    required this.title,
    required this.location,
    required this.memberCount,
  });

  final String imagePath;
  final String title;
  final String location;
  final int memberCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/group/$imagePath.png',
          width: double.infinity,
          height: 280.0,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          height: 280.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withAlpha((0.6 * 255).round()),
                Colors.transparent,
              ],
            ),
          ),
        ),
        Positioned(
          left: 16,
          bottom: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                location,
                style: const TextStyle(
                  color: AppColors.gray100,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.userGroup,
                size: 16,
                color: AppColors.mainPrimary,
              ),
              const SizedBox(width: 4),
              Text(
                '$memberCount명',
                style: const TextStyle(
                  color: AppColors.mainPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
