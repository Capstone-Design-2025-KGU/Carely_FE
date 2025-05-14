import 'package:carely/theme/colors.dart';
import 'package:carely/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MemoScreen extends StatefulWidget {
  const MemoScreen({super.key});

  @override
  State<MemoScreen> createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: ''),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AICard(),
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
                        borderSide: const BorderSide(color: AppColors.gray100),
                      ),
                    ),
                    onChanged: (text) {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AICard extends StatelessWidget {
  const AICard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 400.0,
          decoration: BoxDecoration(),
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
                    '전체 요약',
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
                      children: [
                        IconButton(imagePath: 'all', onPressed: () {}),
                        IconButton(imagePath: 'temperature', onPressed: () {}),
                        IconButton(imagePath: 'meal', onPressed: () {}),
                        IconButton(imagePath: 'walk', onPressed: () {}),
                        IconButton(
                          imagePath: 'communication',
                          onPressed: () {},
                        ),
                        IconButton(imagePath: 'toilet', onPressed: () {}),
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                '이상덕 간병인님의 투약은 하루 2번, 아침 10시와 저녁 6시에 진행합니다. 또한, 복약 후에는 환자 상태를 세심하게 관찰하여 이상 반응이 없는지 확인해야 합니다.\n \n식사는 매일 아침 8시와 저녁 5시에 급여됩니다. 식단은 계란과 우유를 필수로 급여해야합니다. 필요한 경우 추가적인 수분 보충을 권장합니다. ',
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

class IconButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const IconButton({
    super.key,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
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
        child: Image.asset(
          'assets/images/family/skills/$imagePath.png',
          width: 60.0,
          height: 60.0,
        ),
      ),
    );
  }
}
