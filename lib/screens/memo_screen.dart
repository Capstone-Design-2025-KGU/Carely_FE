import 'package:carely/models/nearest_meeting.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:carely/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MemoScreen extends StatefulWidget {
  final NearestMeeting meeting;

  const MemoScreen({super.key, required this.meeting});

  @override
  State<MemoScreen> createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  String _memoText = '';
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    if (!_speech.isAvailable && !_speech.isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _memoText = result.recognizedWords;
            });
          },
        );
      }
    } else if (!_speech.isListening) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) {
          setState(() {
            _memoText = result.recognizedWords;
          });
        },
      );
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: ''),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AICard(meeting: widget.meeting),
                  Container(color: AppColors.gray50, height: 8.0),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '메모',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: AppColors.gray500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextField(
                          maxLines: 8,
                          maxLength: 1000,
                          cursorColor: AppColors.gray300,
                          style: const TextStyle(fontSize: 16.0),
                          decoration: InputDecoration(
                            hintText: '간병의 특이사항이 있을 경우 메모로 남겨주세요!',
                            hintStyle: const TextStyle(
                              color: Color(0xFFC5C9D1), // 연한 회색
                              fontSize: 16,
                            ),
                            counterText: '', // 하단 기본 카운터 제거
                            contentPadding: const EdgeInsets.all(16.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: AppColors.gray100, // 테두리 색
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: AppColors.gray100,
                              ),
                            ),
                          ),
                          onChanged: (text) {
                            setState(() {
                              _memoText = text;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: _startListening,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(51),
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.mic,
                                  color: AppColors.mainPrimary,
                                  size: 32,
                                ),
                              ),
                            ),
                            DefaultButton(
                              content: '메모 저장',
                              onPressed: () {},
                              isEnable: _memoText.trim().isNotEmpty,
                              width: 300,
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextButton(
                          onPressed: () async {},
                          style: TextButton.styleFrom(
                            minimumSize: Size(
                              ScreenSize.width(context, 336),
                              ScreenSize.height(context, 52),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: const BorderSide(color: Colors.red),
                            ),
                            foregroundColor: Colors.red,
                            backgroundColor: Colors.white,
                            textStyle: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: Text('활동 중단'),
                        ),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AICard extends StatefulWidget {
  final NearestMeeting meeting;

  const AICard({super.key, required this.meeting});

  @override
  State<AICard> createState() => _AICardState();
}

class _AICardState extends State<AICard> {
  String get summary {
    switch (selectedCategory) {
      case 'walk':
        return widget.meeting.walk;
      case 'temperature':
        return widget.meeting.health;
      case 'medic':
        return widget.meeting.medic;
      case 'meal':
        return widget.meeting.meal;
      case 'communication':
        return widget.meeting.comm;
      case 'toilet':
        return widget.meeting.toilet;
      case 'all':
      default:
        return '${widget.meeting.walk}\n${widget.meeting.health}\n${widget.meeting.medic}\n${widget.meeting.meal}\n${widget.meeting.toilet}\n${widget.meeting.comm}';
    }
  }

  String selectedCategory = 'all';

  final Map<String, String> categoryLabels = {
    'all': '전체 요약',
    'temperature': '체온 및 건강상태',
    'medic': '약물 복용',
    'meal': '식사 활동',
    'walk': '신체 활동',
    'communication': '정서 및 사회적 상호작용',
    'toilet': '화장실 사용',
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 400.0,
          child: Image.asset(
            'assets/images/mesh-gradient.png',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset('assets/images/carely-ai.svg', width: 120.0),
                  Text(
                    categoryLabels[selectedCategory]!,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      color: AppColors.mainPrimary,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    height: 80.0,
                    child: Row(
                      children:
                          categoryLabels.keys.map((key) {
                            return SkillButton(
                              imagePath: key,
                              isActive: selectedCategory == key,
                              onPressed: () {
                                setState(() {
                                  selectedCategory = key;
                                });
                              },
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ),
              Text(
                summary,
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.mainPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SkillButton extends StatelessWidget {
  final String imagePath;
  final bool isActive;
  final VoidCallback onPressed;

  const SkillButton({
    super.key,
    required this.imagePath,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final actualPath =
        isActive
            ? 'assets/images/family/skills/$imagePath.png'
            : 'assets/images/family/skills/unable/$imagePath.png';

    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        child: Image.asset(actualPath, width: 60.0, height: 60.0),
      ),
    );
  }
}
