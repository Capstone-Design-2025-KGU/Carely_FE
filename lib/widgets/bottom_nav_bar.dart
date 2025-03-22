import 'package:flutter/material.dart';

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
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/house.png', width: 28, height: 28),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/map-pin.png', width: 28, height: 28),
          label: '이웃',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/users-three.png',
            width: 28,
            height: 28,
          ),
          label: '모임',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/chats-fill.png',
            width: 28,
            height: 28,
          ),
          label: '채팅',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/user.png', width: 28, height: 28),
          label: '마이페이지',
        ),
      ],
    );
  }
}
