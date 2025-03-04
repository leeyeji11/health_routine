import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_routine/presentation/theme/app_color.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final PageController _pageController = PageController(viewportFraction: 1.0);
  int _currentIndex = 0;

  final List<String> _images = [
    'assets/images/start_page/start_image_1.png',
    'assets/images/start_page/start_image_2.png',
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // 🔹 Column이 자식 크기만큼만 차지하도록 설정
        children: [
          SizedBox(height: 52), // Status bar height 고려
          SizedBox(
            height: 300,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _images.length,
              clipBehavior: Clip.hardEdge,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      _images[index],
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          _buildCustomIndicator(), // 직접 만든 인디케이터
          SizedBox(height: 36),
          Text(
            "나만의 운동 계획표를 만들어요",
            style: AppTextStyle.startText,
          ),
          SizedBox(height: 40),
          TextButton(
            onPressed: () {
              context.go('/sign-in');
            },
            style: TextButton.styleFrom(
              backgroundColor: AppColors.secondColor,
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Text(
              "로그인",
              style: AppTextStyle.authTextButton,
            ),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              context.push('/sign-up');
            },
            style: TextButton.styleFrom(
              backgroundColor: AppColors.secondColor,
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Text(
              "회원가입",
              style: AppTextStyle.authTextButton,
            ),
          ),
          SizedBox(height: 40), // 마지막 여백 추가
        ],
      ),
    );
  }

  Widget _buildCustomIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_images.length, (index) {
        return Container(
          width: _currentIndex == index ? 12 : 8,
          height: _currentIndex == index ? 12 : 8,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: _currentIndex == index
                ? AppColors.secondColor
                : AppColors.lightGray,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
