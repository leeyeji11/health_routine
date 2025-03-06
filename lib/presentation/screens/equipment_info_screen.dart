import 'dart:io'; // 추가해야 File을 사용할 수 있음
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';

class EquipmentInfoScreen extends StatelessWidget {
  final String imagePath;
  const EquipmentInfoScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              context.pop();
              context.go('/');
            },
          ),
          title: Text(
            '기구 정보',
            style: AppTextStyle.appBarTitle,
          ),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ 기구 이미지
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 360,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: (imagePath.isNotEmpty && imagePath != '')
                        ? FileImage(File(imagePath)) // 촬영한 이미지 적용
                        : AssetImage('assets/images/equipment/trade_mill.png')
                            as ImageProvider, // 기본 이미지
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ 기구 제목
            Center(
              child: const Text(
                '트레드밀',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // ✅ 기구 설명
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: const Text(
                '트레드밀은 유산소 운동 기구로서 자세한 설명이 필요합니다. '
                '사용법과 특징을 확인해 보세요.',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ 카테고리 태그 (유산소 운동)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color(0xFFDEF0EC),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: const Text(
                      '유산소 운동',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/bookmark_selected.svg',
                    height: 30,
                    width: 30,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),

            // ✅ 매뉴얼 섹션
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: const Text(
                '매뉴얼',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 4,
                      spreadRadius: 2),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/workout/running3.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      '트레드밀 매뉴얼/사용법 상세 트레드밀 매뉴얼/사용법 상세 트레드밀 매뉴얼/사용법 상세 트레드밀 매뉴얼/사용법 상세 트레드밀 매뉴얼/사용법 상세 트레드밀 매뉴얼/사용법 상세트레드밀 매뉴얼/사용법 상세',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ✅ 영상 자료 섹션
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: const Text(
                '영상 자료',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // ✅ 영상 항목 1
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/workout/running2.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Icon(
                  Icons.play_arrow,
                  size: 50,
                  color: Colors.white,
                ),
              ],
            ),
            // ✅ 영상 항목 2
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/workout/running1.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Icon(
                  Icons.play_arrow,
                  size: 50,
                  color: Colors.white,
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
