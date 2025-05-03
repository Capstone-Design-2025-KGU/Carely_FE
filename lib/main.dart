import 'package:carely/models/address.dart';
import 'package:carely/models/member.dart';
import 'package:carely/models/skill.dart';
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
import 'package:carely/utils/member_type.dart';
import 'package:carely/utils/skill_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();

  final token = await TokenStorageService.getToken();
  Member? fetchedMember;
  String? validToken = token;

  if (token != null) {
    try {
      fetchedMember = await MemberService.instance.fetchMyInfo(token);
      if (fetchedMember != null) {
        logger.i('✅ 토큰 유효함, 멤버 로드됨: ${fetchedMember.toJson()}');
      } else {
        logger.e('❌ 토큰은 있었지만, 멤버가 null입니다.');
        await TokenStorageService.deleteToken();
        validToken = null;
      }
    } catch (e) {
      logger.e('❌ 토큰 유효하지 않음 또는 멤버 로드 실패: $e');
      await TokenStorageService.deleteToken();
      validToken = null;
    }
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = MemberProvider();
            if (fetchedMember != null) {
              provider.setMember(fetchedMember);
            } else {
              provider.setMember(_emptyMember());
            }
            return provider;
          },
        ),
      ],
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
      debugShowCheckedModeBanner: false,
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
            (context) => const ChatScreen(
              chatRoomId: 1,
              senderId: 1,
              opponentName: '',
              opponentMemberId: 1,
              senderType: MemberType.caregiver,
            ),
        NavScreen.id: (context) => const NavScreen(),
        MapScreen.id: (context) => const MapScreen(),
      },
    );
  }
}

Member _emptyMember() {
  return Member(
    memberId: 0,
    username: '',
    password: '',
    name: '',
    phoneNumber: '',
    birth: '',
    story: '',
    memberType: MemberType.family,
    isVisible: true,
    isVerified: false,
    profileImage: null,
    createdAt: null,
    address: Address(
      province: '',
      city: '',
      district: '',
      details: '',
      latitude: 0.0,
      longitude: 0.0,
    ),
    skill: Skill(
      communication: SkillLevel.low,
      meal: SkillLevel.low,
      toilet: SkillLevel.low,
      bath: SkillLevel.low,
      walk: SkillLevel.low,
    ),
  );
}
