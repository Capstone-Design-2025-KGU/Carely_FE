import 'package:carely/providers/member_provider.dart';
import 'package:carely/screens/chat/chat_screen.dart';
import 'package:carely/screens/home_screen.dart';
import 'package:carely/screens/nav_screen.dart';
import 'package:carely/screens/map/map_screen.dart';
import 'package:carely/screens/onboarding/login_screen.dart';
import 'package:carely/services/auth/token_storage_service.dart';
import 'package:carely/services/member/member_service.dart';
import 'package:carely/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();

  final token = await TokenStorageService.getToken();

  final memberProvider = MemberProvider();

  if (token != null) {
    final member = await MemberService.instance.fetchMyInfo(token);
    if (member != null) {
      memberProvider.setMember(member);
    }
  }

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => memberProvider)],
      child: MyApp(initialToken: token),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? initialToken;

  const MyApp({super.key, this.initialToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ko', 'KR'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ko'), Locale('en')],
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
      initialRoute: initialToken == null ? LoginScreen.id : NavScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        ChatScreen.id:
            (context) =>
                const ChatScreen(chatRoomId: 1, senderId: 1, opponentName: ''),
        NavScreen.id: (context) => const NavScreen(),
        MapScreen.id: (context) => const MapScreen(),
      },
    );
  }
}
