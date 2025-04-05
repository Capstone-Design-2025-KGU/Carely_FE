import 'package:carely/screens/onboarding/type_select_screen.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/widgets/default_button.dart';

class TermScreen extends StatefulWidget {
  static String id = 'term-screen';
  const TermScreen({super.key});

  @override
  State<TermScreen> createState() => _TermScreenState();
}

class _TermScreenState extends State<TermScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolledToBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  /// 유저 스크롤을 감지하는 함수입니다.
  /// _scrollController.position.pixels → 현재 스크롤 위치
  /// _scrollController.position.maxScrollExtent → 스크롤할 수 있는 최대 길이
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      if (!_isScrolledToBottom) {
        setState(() {
          _isScrolledToBottom = true;
        });
      }
    } else {
      if (_isScrolledToBottom) {
        setState(() {
          _isScrolledToBottom = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(title: '회원가입'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '약관에 먼저 동의해 주세요',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray800,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      '''
아래는 범죄경력 조회 동의서 약관의 예시입니다. 이 약관은 대상자의 동의를 받고 법적 요건을 충족하는 내용을 포함하고 있습니다. 실제 사용 시에는 법적 검토를 거치는 것이 중요합니다.
            
범죄경력 조회 동의서
                
제1조 (목적)본 동의서는 [시설명]이 간병인 및 자원봉사자의 신원 확인 및 안전한 서비스 제공을 목적으로 범죄경력 조회를 실시함에 있어, 대상자의 사전 동의를 받기 위해 작성되었습니다.
                
제2조 (조회 대상 및 범위)
조회 대상은 [시설명]의 회원으로 가입하고 간병 활동을 희망하는 요양보호사 및 자원봉사자에 한합니다.
조회 범위는 대한민국 법률에 따라 경찰청에서 제공하는 범죄경력 및 수사경력 자료입니다.
조회된 정보는 다음의 목적 외에는 사용되지 않습니다.
            
              - 안전한 서비스 제공을 위한 신원 확인
              - 자격 적합성 검토
                
제3조 (조회 절차)
대상자는 본 동의서에 서명함으로써 범죄경력 조회를 승인하며, 경찰청의 협조를 통해 조회가 이루어집니다.
조회 결과는 [시설명]의 담당자에게만 전달되며, 대상자의 사전 동의 없이 제3자에게 공개되지 않습니다.
                
제4조 (정보 보호 및 관리)
조회된 정보는 개인정보 보호법 및 관련 법령에 따라 철저히 관리되며, 보관 기간은 조회일로부터 [보관 기간] 이내로 제한합니다.
조회된 정보는 목적 달성 후 즉시 폐기합니다.
                
제5조 (동의 철회 및 거부권)
대상자는 범죄경력 조회 동의를 거부할 권리가 있습니다. 다만, 동의를 거부할 경우 회원가입 및 간병 활동이 제한될 수 있습니다.
대상자는 조회 신청 후에도 동의를 철회할 수 있으며, 철회 시 관련 절차를 중단합니다.
                
제6조 (책임과 면책)
[시설명]은 대상자의 범죄경력을 조회하며, 조회 과정에서 발생하는 문제에 대해 관련 법률에 따른 책임을 부담합니다.
조회 결과에 따라 서비스 제공이 제한될 수 있음을 대상자에게 미리 안내합니다.
                
동의 내용 확인 및 서명본인은 상기 내용을 충분히 이해하였으며, [시설명]이 본인의 범죄경력을 조회하는 것에 동의합니다.
                ''',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: DefaultButton(
              content: '약관 동의하기',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TypeSelectScreen(),
                  ),
                );
              },
              isEnable: _isScrolledToBottom,
            ),
          ),
        ],
      ),
    );
  }
}
