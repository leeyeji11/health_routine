import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_routine/core/show_snack_bars.dart';
import 'package:health_routine/gen/assets.gen.dart';
import 'package:go_router/go_router.dart';
import 'package:health_routine/presentation/theme/app_color.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> signOut() async {
      try {
        print("🧡 로그아웃 시도 중...");

        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool hasData = prefs.getKeys().isNotEmpty;
        print("🧡 로그인 정보 존재 여부: $hasData");

        if (!hasData) {
          Showsnackbars.showSnackBar(context, "비회원입니다.");
          print("⚠ 비회원 상태 확인됨");
          return;
        }
        await FirebaseAuth.instance.signOut();
        print("⭐️ Firebase 로그아웃 완료");

        await prefs.clear();
        print("⭐️ SharedPreferences 초기화 완료");

        Showsnackbars.showSnackBar(context, "로그아웃되었습니다.");

        if (context.mounted) {
          context.go('/');
          print("✔ 로그인 화면으로 이동 완료");
        } else {
          print("⚠ context가 이미 dispose됨");
        }
      } catch (e, stackTrace) {
        print("❌ 로그아웃 중 오류 발생: $e");
        print("🛠 오류 스택 트레이스: $stackTrace");
        Showsnackbars.showSnackBar(context, "로그아웃에 실패했습니다.");
      }
    }

    final List<Map<String, dynamic>> menuItems = [
      {
        'title': '내 북마크',
        'icon': Icons.bookmark_border,
        'onTap': () {
          context.push('/bookmark');
        }
      },
      {'title': '개인정보 수정', 'icon': Icons.person_outline, 'onTap': () {}},
      {
        'title': '로그아웃',
        'icon': Icons.logout,
        'onTap': () {
          signOut();
        }
      },
      {
        'title': '회원 탈퇴',
        'icon': Icons.warning_amber_outlined,
        'onTap': () {},
        'isDestructive': true
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          '프로필',
          style: AppTextStyle.appBarTitle,
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 40),

          // 📌 block
          CircleAvatar(
            radius: 45,
            backgroundColor: AppColors.white,
            child: Assets.icons.profile.svg(
              width: 90,
              height: 90,
              colorFilter:
                  ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            ),
          ),
          const SizedBox(height: 16),

          // 이름
          Text(
            '이름',
            style: AppTextStyle.profileName,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // 레벨 박스
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              decoration: BoxDecoration(
                  color: AppColors.softMint,
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('레벨 3', style: AppTextStyle.profileLevel),
                  SizedBox(width: 4),
                  Icon(Icons.star, color: AppColors.secondColor),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 📌 block
          _buildInfoSection(),

          const SizedBox(height: 24),

          // 📌 block
          _buildWorkoutStats(),

          const SizedBox(height: 24),

          // 📌 block
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: menuItems.length,
            separatorBuilder: (_, __) =>
                Divider(height: 1, color: Color(0xFFD2E6E6)),
            itemBuilder: (context, index) {
              final item = menuItems[index];
              return ListTile(
                leading: Icon(item['icon'],
                    color: item['isDestructive'] == true
                        ? Colors.red
                        : Colors.black),
                title: Text(
                  item['title'],
                  style: AppTextStyle.profileSubtitle.copyWith(
                    color: item['isDestructive'] == true
                        ? Colors.red
                        : AppColors.black,
                  ),
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: item['onTap'],
              );
            },
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  /// 📌 신체 정보 카드
  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '내 신체 정보',
                  style: AppTextStyle.profileSubtitle,
                ),
                Container(
                  width: 60,
                  height: 35,
                  decoration: BoxDecoration(
                      color: AppColors.softTeal,
                      borderRadius: BorderRadius.circular(16)),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      '수정',
                      style: AppTextStyle.profilebutton,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _infoBox(
                icon: SvgPicture.asset('assets/icons/female.svg',
                    width: 16, height: 16),
              ),
              SizedBox(width: 8),
              _infoBox(text: '25세'),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              _infoBox(text: '165cm'),
              SizedBox(width: 8),
              _infoBox(text: '55kg'),
              SizedBox(width: 8),
              _infoBox(text: 'BMI 20.2'),
            ],
          )
        ],
      ),
    );
  }

  /// 📌 운동 통계
  Widget _buildWorkoutStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '내 운동 경과',
                style: AppTextStyle.profileSubtitle,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                    color: Color(0xFFE1F2EE),
                    borderRadius: BorderRadius.circular(16)),
                child:
                    Text('주간', style: AppTextStyle.profilebutton), // Todo: 드롭다운
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 50, // 필요에 따라 조정 가능
                child: Column(
                  children: [
                    Text(
                      '20%',
                      style: AppTextStyle.profileRate,
                    ),
                    Text(
                      '달성',
                      style: AppTextStyle.profileRate,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(7, (index) {
                    return Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 50, // 높이는 유지
                            width: 20,
                            decoration: BoxDecoration(
                              color: index == 0
                                  ? AppColors.secondColor
                                  : AppColors.softMint,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            ['S', 'M', 'T', 'W', 'T', 'F', 'S'][index],
                            style: AppTextStyle.profilWeek,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 📌 신체 정보 박스 (SVG 추가 가능)
  Widget _infoBox({String? text, Widget? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.mediumTeal,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon,
            if (text != null && text.isNotEmpty) const SizedBox(width: 8),
          ],
          if (text != null && text.isNotEmpty)
            Text(
              text,
              style: AppTextStyle.profileInfo,
            ),
        ],
      ),
    );
  }
}
