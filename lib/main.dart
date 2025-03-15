import 'package:carely/screens/home_screen.dart';
import 'package:carely/screens/onboarding/login_screen.dart';
import 'package:carely/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carely',
      theme: ThemeData(
        fontFamily: 'Pretendard',
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.gray800, size: 20.0),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: LoginScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
      },
    );
  }
}
