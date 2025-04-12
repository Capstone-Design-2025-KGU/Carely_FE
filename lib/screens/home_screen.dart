import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:carely/models/address.dart';
import 'package:carely/providers/member_provider.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/utils/member_color.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:carely/widgets/default_app_bar.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _displayMemberType(MemberType? type) {
    switch (type) {
      case MemberType.family:
        return '가족 간병인';
      case MemberType.volunteer:
        return '자원봉사자';
      case MemberType.caregiver:
        return '예비 요양보호사';
      default:
        return '회원';
    }
  }

  String _pathMemberType(MemberType? type) {
    switch (type) {
      case MemberType.family:
        return 'family';
      case MemberType.volunteer:
        return 'volunteer';
      case MemberType.caregiver:
        return 'caregiver';
      default:
        return '회원';
    }
  }

  String _formatAddress(Address? address) {
    if (address == null) return '';
    return '${address.province} ${address.city} ${address.district}';
  }

  @override
  Widget build(BuildContext context) {
    final member = context.watch<MemberProvider>().member;
    final memberName = member?.name;
    final memberType = member?.memberType;
    final logoPath = _pathMemberType(memberType);
    final highlightColor = getHighlightColor(memberType!);
    final backgroundColor = getBackgroundColor(memberType);

    return Scaffold(
      appBar: DefaultAppBar(title: '', isHome: true),
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                'assets/images/$logoPath/logo.svg',
                width: ScreenSize.width(context, 220.0),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Text(
                      '안녕하세요 $memberName님,\n내 주변 도움을 받아보세요!',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray800,
                      ),
                    ),
                  ),
                  Container(
                    width: ScreenSize.width(context, 336.0),
                    height: ScreenSize.height(context, 84.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: '나는 ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                    color: AppColors.gray800,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: _displayMemberType(memberType),
                                      style: TextStyle(
                                        color: highlightColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: '이에요',
                                      style: TextStyle(
                                        color: AppColors.gray800,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                _formatAddress(member?.address),
                                style: TextStyle(
                                  color: AppColors.gray600,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: ScreenSize.width(context, 96.0),
                            height: ScreenSize.height(context, 32.0),
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                '이웃 인증 완료',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                  color: highlightColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  MenuTitle(title: '나랑 잘 맞는 이웃'),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    child: Row(
                      children: [
                        MemberCard(),
                        MemberCard(),
                        MemberCard(),
                        MemberCard(),
                        MemberCard(),
                      ],
                    ),
                  ),
                  SizedBox(height: 36.0),
                  MenuTitle(title: '내 주변 이웃 찾아보기'),
                  SizedBox(height: 36.0),
                  MenuTitle(title: '함께한 추억'),
                  MemoryCard(),
                  SizedBox(height: 12.0),
                  MemoryCard(),
                  SizedBox(height: 40.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MemoryCard extends StatelessWidget {
  const MemoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.width(context, 336.0),
      height: ScreenSize.height(context, 88.0),
      decoration: BoxDecoration(
        color: AppColors.main50,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset('assets/images/family/profile/1.png'),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '간병인 이상덕님',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray600,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '전문적이세요! 너무 너무 감사합니다. 다음에 또 뵐 수 있으면 좋겠습니다. 다음에 또 뵈면 제가 맛있는 음식을 대접하는 것으로 약속',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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

// ignore: must_be_immutable
class MenuTitle extends StatelessWidget {
  String title;

  MenuTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: AppColors.gray800,
            ),
          ),
          Text(
            '더보기',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: AppColors.gray600,
            ),
          ),
        ],
      ),
    );
  }
}

class MemberCard extends StatelessWidget {
  const MemberCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      //TODO: 패딩 동적으로 수정
      child: Container(
        width: ScreenSize.width(context, 126.0),
        height: ScreenSize.height(context, 160.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 4.0),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/family/profile/1.png'),
            SizedBox(height: 4.0),
            Text(
              '이규민',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: AppColors.gray800,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              '3Km',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: AppColors.gray300,
              ),
            ),
            SizedBox(height: 4.0),
            Container(
              width: ScreenSize.width(context, 100.0),
              height: ScreenSize.height(context, 26.0),
              decoration: BoxDecoration(color: AppColors.main50),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidClock,
                    size: 16.0,
                    color: AppColors.mainPrimary,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    '함께한 22시간',
                    style: TextStyle(
                      color: AppColors.mainPrimary,
                      fontWeight: FontWeight.w600,
                    ),
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
