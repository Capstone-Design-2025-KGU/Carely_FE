import 'package:carely/models/member.dart';
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

  Member? initialMember;
  if (token != null) {
    initialMember = await MemberService.instance.fetchMyInfo(token);
  }

  runApp(MyApp(initialToken: token, initialMember: initialMember));
}

class MyApp extends StatelessWidget {
  final String? initialToken;
  final Member? initialMember;

  const MyApp({super.key, this.initialToken, this.initialMember});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MemberProvider>(
          create: (_) => MemberProvider()..setMember(initialMember!),
        ),
      ],
      child: MaterialApp(
        locale: const Locale('ko', 'KR'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ko'),
          Locale('en'), // 필요 시 추가
        ],
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
        initialRoute: NavScreen.id,
        routes: {
          HomeScreen.id: (context) => const HomeScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          ChatScreen.id:
              (context) => const ChatScreen(
                chatRoomId: 1,
                senderId: 1,
                opponentName: '',
              ),
          NavScreen.id: (context) => const NavScreen(),
          MapScreen.id: (context) => const MapScreen(),
        },
      ),
    );
  }
}
