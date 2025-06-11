import 'dart:async';

import 'package:carely/models/nearest_meeting.dart';
import 'package:carely/providers/nearest_meeting_provider.dart';
import 'package:carely/services/auth/token_storage_service.dart';
import 'package:carely/services/meeting_service.dart';
import 'package:carely/services/memo_service.dart';
import 'package:carely/theme/colors.dart';
import 'package:carely/utils/logger_config.dart';
import 'package:carely/utils/screen_size.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:carely/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
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
  late NearestMeeting _meeting;
  String selectedCategory = 'all';
  String summary = '';
  late TextEditingController _memoController;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _meeting = widget.meeting;
    summary = _buildSummary(_meeting, selectedCategory);

    _memoController = TextEditingController(); // 🎯 이거 추가
    _initSpeechRecognition();
  }

  Future<void> _initSpeechRecognition() async {
    final micStatus = await Permission.microphone.status;

    if (micStatus != PermissionStatus.granted) {
      final result = await Permission.microphone.request();
      if (result != PermissionStatus.granted) {
        logger.i('❌ 마이크 권한 거부됨');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('마이크 권한이 필요합니다. 설정에서 허용해주세요.')),
          );
        }
        return;
      }
    }

    final available = await _speech.initialize(
      onStatus: (status) {
        logger.i('🟢 Speech status: $status');
        if (status == 'notListening' || status == 'done') {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(); // 팝업 닫기
          }
          setState(() => _isListening = false);
        }
      },
      onError: (error) => logger.i('❌ Speech error: $error'),
    );

    if (!available) {
      logger.i('⚠️ Speech recognition unavailable');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('음성 인식을 사용할 수 없습니다.')));
      }
    } else {
      logger.i('✅ 음성 인식 초기화 성공');
    }
  }

  String _buildSummary(NearestMeeting meeting, String category) {
    String safe(String? text) => text?.trim().isNotEmpty == true ? text! : '-';

    switch (category) {
      case 'walk':
        return safe(meeting.walk);
      case 'temperature':
        return safe(meeting.health);
      case 'medic':
        return safe(meeting.medic);
      case 'meal':
        return safe(meeting.meal);
      case 'communication':
        return safe(meeting.comm);
      case 'toilet':
        return safe(meeting.toilet);
      case 'all':
      default:
        return [
          meeting.walk,
          meeting.health,
          meeting.medic,
          meeting.meal,
          meeting.toilet,
          meeting.comm,
        ].map(safe).join('\n');
    }
  }

  void _startListening() async {
    if (!_isListening &&
        await _speech.hasPermission &&
        _speech.isNotListening) {
      setState(() => _isListening = true);

      _showListeningDialog(); // 팝업 먼저 띄우고

      await _speech.listen(
        onResult: (result) {
          setState(() {
            _memoText = result.recognizedWords;
            _memoController.text = _memoText;
          });

          // 결과가 확정되었으면 팝업 닫기
          if (result.finalResult && mounted) {
            Navigator.of(context, rootNavigator: true).maybePop();
            setState(() => _isListening = false);
          }
        },
        listenOptions: stt.SpeechListenOptions(
          partialResults: true,
          listenMode: stt.ListenMode.dictation,
        ),
      );
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  void _showListeningDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true, // ✅ 이걸 반드시 넣어야 MemoScreen이 안 닫힘
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(color: AppColors.mainPrimary),
                SizedBox(height: 20),
                Text(
                  '듣고 있어요...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
                  AICard(
                    selectedCategory: selectedCategory,
                    summary: summary,
                    onCategoryChanged: (category) {
                      setState(() {
                        selectedCategory = category;
                        summary = _buildSummary(_meeting, category);
                      });
                    },
                  ),
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
                          controller: _memoController,
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
                              onPressed: () async {
                                final token =
                                    await TokenStorageService.getToken();
                                final memberId =
                                    widget.meeting.receiver.memberId;

                                if (token != null) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    barrierColor: Colors.black.withOpacity(0.3),
                                    builder: (_) => const LoadingDialog(),
                                  );

                                  try {
                                    await MemoService.updateMemo(
                                      memberId: memberId,
                                      memoText: _memoText,
                                      token: token,
                                    );

                                    final updated =
                                        await MemoService.getMemoSummary(
                                          memberId: memberId,
                                          token: token,
                                        );

                                    if (updated != null) {
                                      setState(() {
                                        _meeting = _meeting.copyWith(
                                          walk: updated.walk,
                                          health: updated.health,
                                          medic: updated.medic,
                                          meal: updated.meal,
                                          toilet: updated.toilet,
                                          comm: updated.comm,
                                        );
                                        summary = _buildSummary(
                                          _meeting,
                                          selectedCategory,
                                        );
                                      });
                                    }

                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('메모가 저장되었습니다')),
                                    );
                                  } catch (_) {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('메모 저장에 실패했습니다')),
                                    );
                                  }
                                }
                              },

                              isEnable: _memoText.trim().isNotEmpty,
                              width: 300,
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextButton(
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (_) => const ActivityStopDialog(),
                            );

                            if (confirm != true) return;

                            final token = await TokenStorageService.getToken();
                            if (token == null) return;

                            try {
                              await MeetingService.rejectMeeting(
                                meetingId: widget.meeting.meetingId,
                                token: token,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('활동이 중단되었습니다')),
                              );

                              Navigator.of(context).pop(); // MemoScreen 닫기
                            } catch (_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('활동 중단에 실패했습니다')),
                              );
                            }
                          },
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

class AICard extends StatelessWidget {
  final String selectedCategory;
  final String summary;
  final void Function(String) onCategoryChanged;

  const AICard({
    super.key,
    required this.selectedCategory,
    required this.summary,
    required this.onCategoryChanged,
  });

  final Map<String, String> categoryLabels = const {
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: 400.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/mesh-gradient.png'),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 28.0,
              horizontal: 20.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/images/carely-ai.svg',
                      width: 120.0,
                    ),
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
                                onPressed: () => onCategoryChanged(key),
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
        );
      },
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

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/lottie/loading.json',
              width: 120,
              height: 120,
              fit: BoxFit.contain,
              repeat: true,
            ),
            const SizedBox(height: 16),
            const Text(
              '저장 중이에요...',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityStopDialog extends StatelessWidget {
  const ActivityStopDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: AppColors.mainPrimary,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              '활동 중단하시겠어요?',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
                color: AppColors.gray900,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              '이 작업은 되돌릴 수 없어요.\n정말로 중단하시겠습니까?',
              style: TextStyle(
                fontSize: 14.5,
                color: AppColors.gray600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.gray500,
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    child: const Text('취소'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                      Provider.of<NearestMeetingProvider>(
                        context,
                        listen: false,
                      ).clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainPrimary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('중단'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
