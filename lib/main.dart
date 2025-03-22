import 'package:carely/screens/chat/chat_screen.dart';
import 'package:carely/screens/home_screen.dart';
<<<<<<< HEAD
import 'package:carely/screens/nav_screen.dart';
=======
import 'package:carely/screens/map/map_screen.dart';
>>>>>>> 803dd41 (feat : import map marker)
import 'package:carely/screens/onboarding/login_screen.dart';
import 'package:carely/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carely',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Pretendard',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: AppColors.gray800, size: 20.0),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
<<<<<<< HEAD
      initialRoute: NavScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        ChatScreen.id:
            (context) =>
                const ChatScreen(chatRoomId: 1, senderId: 1, opponentName: ''),
        NavScreen.id: (context) => const NavScreen(),
=======
      initialRoute: MapScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        MapScreen.id: (context) => const MapScreen(),
>>>>>>> 803dd41 (feat : import map marker)
      },
    );
  }
}
