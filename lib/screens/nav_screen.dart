import 'package:carely/screens/chat/chat_room_screen.dart';
import 'package:carely/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:carely/widgets/bottom_nav_bar.dart';

class NavScreen extends StatefulWidget {
  static String id = 'nav-screen';
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    ChatRoomScreen(),
    HomeScreen(),
  ]; // 다른 스크린 파일 생성시 홈 스크린 지우고 새 스크린 추가.

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
    );
  }
}
