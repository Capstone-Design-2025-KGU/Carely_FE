import 'package:carely/models/member.dart';
import 'package:carely/providers/member_provider.dart';
import 'package:carely/screens/chat/chat_screen.dart';
import 'package:carely/screens/home_screen.dart';
import 'package:carely/screens/nav_screen.dart';
import 'package:carely/screens/map/map_screen.dart';
import 'package:carely/screens/onboarding/login_screen.dart';
import 'package:carely/screens/onboarding/term_screen.dart';
import 'package:carely/services/auth/token_storage_service.dart';
import 'package:carely/services/member/member_service.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();

  Member? member;
  String? validToken;
  final memberProvider = MemberProvider();
  final token = await TokenStorageService.getToken();

  if (token != null) {
    try {
      member = await MemberService.instance.fetchMyInfo(token);
      if (member != null) {
        memberProvider.setMember(member);
        validToken = token;
      }
    } catch (e) {
      logger.e('토큰 유효성 검증 실패: $e');
    }
  }

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => memberProvider)],
      child: MyApp(initialToken: validToken),
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
        TermScreen.id: (context) => const TermScreen(),
        ChatScreen.id:
            (context) =>
                const ChatScreen(chatRoomId: 1, senderId: 1, opponentName: ''),
        NavScreen.id: (context) => const NavScreen(),
        MapScreen.id: (context) => const MapScreen(),
      },
    );
  }
}
