import 'package:flutter/material.dart';
import 'package:health_routine/presentation/theme/app_color.dart';

// 📌 기본적인 텍스트 스타일을 한 곳에서 관리
class PretendardText {
  static const TextStyle thin = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w100,
    color: AppColors.black,
  );
  static const TextStyle extraLight = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w200,
    color: AppColors.black,
  );
  static const TextStyle light = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w300,
    color: AppColors.black,
  );
  static const TextStyle regular = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );
  static const TextStyle medium = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
  static const TextStyle semiBold = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );
  static const TextStyle bold = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );
  static const TextStyle extraBold = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w800,
    color: AppColors.black,
  );
  static const TextStyle back = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w900,
    color: AppColors.black,
  );
}

class AppTextStyle {
  // ✅ Urbanist 사용

  static TextStyle splashText = const TextStyle(
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w400,
    fontSize: 25,
    color: AppColors.white, // ⭐️ 스플레쉬
  );

  static TextStyle appBarHR = const TextStyle(
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.italic,
    fontSize: 16,
    color: AppColors.primaryColor, // 💚 앱바 타이틀
  );

  // ✅ Pretendard 사용

  // 중제목 (ex. 추천 운동 루틴)
  static TextStyle subSectionTitle = PretendardText.semiBold.copyWith(
    fontSize: 13,
  );

  // 카드 title
  static TextStyle cardTitle = PretendardText.medium.copyWith(
    fontSize: 12,
  );
  // 카드 descroption
  static TextStyle cardDescription =
      PretendardText.light.copyWith(fontSize: 10);

  // 탭 텍스트
  static TextStyle tabText = PretendardText.semiBold.copyWith(
    fontSize: 16,
    color: AppColors.darkGray,
  );
  static TextStyle tabTextSelected = PretendardText.semiBold.copyWith(
    fontSize: 16,
    color: AppColors.white,
  );

  // 더보기 버튼
  static TextStyle moreButton = PretendardText.extraBold.copyWith(fontSize: 10);

  // 검색창 힌트 텍스트
  static TextStyle searchHint =
      PretendardText.medium.copyWith(fontSize: 15, color: AppColors.darkGray);

  // 검색창 힌트 텍스트
  static TextStyle buttonText =
      PretendardText.extraBold.copyWith(color: AppColors.white);

  // 앱바 타이틀
  static TextStyle appBarTitle = PretendardText.medium.copyWith(fontSize: 20);

  // 캘린더 카드
  static TextStyle calendarCardTitle =
      PretendardText.extraBold.copyWith(fontSize: 20, color: AppColors.white);

  static TextStyle calendarCardSets =
      PretendardText.semiBold.copyWith(fontSize: 12, color: AppColors.white);

  static TextStyle calendarCardTag =
      PretendardText.light.copyWith(fontSize: 10);

// 프로필 화면
  static TextStyle profileName =
      PretendardText.bold.copyWith(fontSize: 20, color: AppColors.darkGray);

  static TextStyle profileLevel = PretendardText.bold.copyWith(fontSize: 14);

  static TextStyle profileSubtitle =
      PretendardText.regular.copyWith(fontSize: 14);

  static TextStyle profilebutton =
      PretendardText.regular.copyWith(fontSize: 14);

  static TextStyle profileInfo = PretendardText.light.copyWith(fontSize: 12);

  static TextStyle profileRate = PretendardText.medium
      .copyWith(fontSize: 14, color: AppColors.secondColor);

  static TextStyle profilWeek = PretendardText.regular
      .copyWith(fontSize: 14, color: AppColors.darkCharcoal);

  // 회원

  static TextStyle authTitle = PretendardText.semiBold.copyWith(fontSize: 24);
  static TextStyle authTextField = PretendardText.medium.copyWith(fontSize: 14);
  static TextStyle authTextButton =
      PretendardText.medium.copyWith(fontSize: 14, color: AppColors.white);
  static TextStyle authAutoLogin =
      PretendardText.regular.copyWith(fontSize: 12);

  static TextStyle startText = PretendardText.medium.copyWith(fontSize: 20);

  // 📸 카메라 Screen
  static TextStyle cameraDesc = PretendardText.extraBold
      .copyWith(fontSize: 15, color: AppColors.white); // 카메라 설명 텍스트

  //   static TextStyle smallTitleDark = smallTitle.copyWith(color: Colors.white);
  // static TextStyle smallTitleLight = smallTitle.copyWith(color: Colors.black);
}
