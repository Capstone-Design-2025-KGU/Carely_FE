import 'package:carely/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.gray50, width: 1)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.gray800,
            selectedLabelStyle: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: AppColors.gray800,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: AppColors.gray300,
            ),

            items: [
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.house),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.locationPin),
                label: '이웃',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.users),
                label: '모임',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.message),
                label: '채팅',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.user),
                label: '마이페이지',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
