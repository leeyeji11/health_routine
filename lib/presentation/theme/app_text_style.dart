import 'package:flutter/material.dart';
import 'package:health_routine/presentation/theme/app_color.dart';

class AppTextStyle {
  static TextStyle appBarTitle = const TextStyle(
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.italic,
    fontSize: 16,
    color: AppColors.primaryColor, // 💚 앱바 타이틀
  );
  static TextStyle subSectionTitle = const TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.bold,
    fontSize: 13,
    color: AppColors.black, // 부제목 (카드의 제목)
  );
  static TextStyle smallTitle = const TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.darkGray,
  );

  static TextStyle workoutDescription = const TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w300,
    fontSize: 10,
    color: AppColors.black, // 운동 루틴 설명
  );

  static TextStyle moreButton = const TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: AppColors.black, // 더보기 버튼
  );

  //   static TextStyle smallTitleDark = smallTitle.copyWith(color: Colors.white);
  // static TextStyle smallTitleLight = smallTitle.copyWith(color: Colors.black);
}
