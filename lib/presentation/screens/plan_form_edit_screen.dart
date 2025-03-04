import 'package:flutter/material.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';

class PlanFormEditScreen extends StatefulWidget {
  const PlanFormEditScreen({super.key});

  @override
  State<PlanFormEditScreen> createState() => _PlanFormEditScreenState();
}

class _PlanFormEditScreenState extends State<PlanFormEditScreen> {
  @override
  Widget build(BuildContext context) {
    // Todo: 수정하는 화면으로 재사용해도 좋을것같음
    return Scaffold(
      backgroundColor: Color(0xFFF2F7F7),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F7F7),
        elevation: 0,
        title: Text("플래너 편집", style: AppTextStyle.appBarTitle),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF201600)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 운동 이미지
              Container(
                width: double.infinity,
                height: 189,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/treadmill.jpg"), // 운동 이미지
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // 운동 제목
              const Text(
                "트레드밀",
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 4,
                color: Color(0xFFDAEDED),
              ),
              const SizedBox(height: 10),

              // 날짜 선택
              const Text(
                "날짜",
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _buildInfoBox("10월 17일 - 11월 17일", Icons.calendar_today),

              const SizedBox(height: 16),

              // 시간 & 세트 선택
              const Text(
                "시간/세트",
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildSelectableBox("1 시간", Icons.watch_later),
                  const SizedBox(width: 16),
                  _buildSelectableBox("3 세트", Icons.check_circle),
                ],
              ),

              const SizedBox(height: 16),

              // 카테고리
              const Text(
                "카테고리",
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _buildCategoryTag("유산소 운동"),

              const SizedBox(height: 24),

              // 운동 계획 세우기 버튼
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // 운동 계획 추가 기능
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF54D6B8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  child: const Text(
                    "운동 계획 세우기",
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      // 하단 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF54D6B8),
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: "카메라",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "캘린더",
          ),
        ],
      ),
    );
  }

  // 날짜 & 시간 박스
  Widget _buildInfoBox(String text, IconData icon) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(icon, color: Color(0xFF54D6B8)),
          ),
        ],
      ),
    );
  }

  // 선택 가능한 버튼 스타일 박스 (시간, 세트)
  Widget _buildSelectableBox(String text, IconData icon) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Color(0xFF54D6B8)),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // 카테고리 태그
  Widget _buildCategoryTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFFDEF0EC),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 10,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
      ),
    );
  }
}
