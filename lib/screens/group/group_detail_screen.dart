import 'package:carely/theme/colors.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupDetailScreen extends StatelessWidget {
  final String title;
  final String location;
  final int recentUpdate;
  final String imagePath;
  final int memberCount;

  const GroupDetailScreen({
    super.key,
    required this.title,
    required this.location,
    required this.recentUpdate,
    required this.imagePath,
    required this.memberCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: title),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GroupCover(
              imagePath: imagePath,
              title: title,
              location: location,
              memberCount: memberCount,
            ),
            SizedBox(height: 36.0),
            Column(
              children: [
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
                NeighborNewsCard(
                  imageIndex: '1',
                  title: '안녕하세요 새롭게 가입하게 되었습니다. 잘 부탁드립니다.',
                  content: '모두들 만나서 반가우요모두들 만나서 반가우요반가우요반가우요',
                  commentCount: 3,
                ),
                NeighborNewsCard(
                  imageIndex: '2',
                  title: '오늘 날씨 진짜 좋네요!',
                  content: '우리 동네도 산책 나가기 딱 좋습니다요~',
                  commentCount: 5,
                ),
                NeighborNewsCard(
                  imageIndex: '3',
                  title: '행복한 아침 ^^',
                  content: '이웃 여러분 오늘도 아침 해가 동그랗게 떳습니다. 아자아자 힘을 내고',
                  commentCount: 6,
                ),
                NeighborNewsCard(
                  imageIndex: '3',
                  title: '행복한 아침 ^^',
                  content: '이웃 여러분 오늘도 아침 해가 동그랗게 떳습니다. 아자아자 힘을 내고',
                  commentCount: 6,
                ),
                NeighborNewsCard(
                  imageIndex: '3',
                  title: '행복한 아침 ^^',
                  content: '이웃 여러분 오늘도 아침 해가 동그랗게 떳습니다. 아자아자 힘을 내고',
                  commentCount: 6,
                ),
              ],
            ),
          ],
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
