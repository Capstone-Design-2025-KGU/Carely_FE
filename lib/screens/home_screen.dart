import 'package:carely/models/address.dart';
import 'package:carely/providers/member_provider.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/utils/member_color.dart';
import 'package:carely/utils/member_type.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
                      '안녕하세요 $memberName,\n내 주변 도움을 받아보세요!',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
