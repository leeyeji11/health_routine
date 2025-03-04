import 'package:flutter/material.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '내 북마크',
          style: AppTextStyle.appBarTitle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 20),

          // 운동 루틴 섹션
          _sectionTitle('운동 루틴'),
          _bookmarkItem(
            title: '스트레칭 루틴',
            description: '운동 전 몸풀기용 전신 스트레칭 20분',
            imagePath: 'assets/images/workout/stretching.png',
          ),
          _bookmarkItem(
            title: '유산소 루틴',
            description: '러닝머신 30분 + 스쿼트 15분',
            imagePath: 'assets/images/workout/stretching.png',
          ),

          const SizedBox(height: 24),

          // 운동 기구 섹션
          _sectionTitle('운동 기구'),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              _equipmentItem('덤벨', 'assets/images/equipment/cycle.png'),
              _equipmentItem('요가매트', 'assets/images/equipment/cycle.png'),
              _equipmentItem('운동밴드', 'assets/images/equipment/cycle.png'),
              _equipmentItem('푸쉬업바', 'assets/images/equipment/cycle.png'),
            ],
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  /// 📌 섹션 제목
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
      ),
    );
  }

  /// 📌 북마크된 운동 루틴 아이템
  Widget _bookmarkItem(
      {required String title,
      required String description,
      required String imagePath}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Color(0xFFF2F7F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(10)),
            child: Image.asset(imagePath,
                width: 110, height: 88, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  /// 📌 운동 기구 아이템
  Widget _equipmentItem(String name, String imagePath) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(imagePath,
                width: 140, height: 100, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
