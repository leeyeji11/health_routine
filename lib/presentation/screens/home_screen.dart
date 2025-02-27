import 'package:flutter/material.dart';
import 'package:health_routine/data/routine_mock_data.dart';
import 'package:health_routine/domain/entities/routine.dart';
import 'package:health_routine/gen/assets.gen.dart';
import 'package:health_routine/presentation/theme/app_color.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';
import 'package:health_routine/presentation/widgets/home_screen/equipment_search_block.dart';
import 'package:health_routine/presentation/widgets/home_screen/recommended_workout_tab_bar.dart';
import 'package:health_routine/presentation/widgets/home_screen/recommended_workout_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0; // 선택된 탭 인덱스 (0: 초급, 1: 중급, 2: 상급, 3: 스트레칭)

  final List<String> tabs = ["초급", "중급", "상급", "스트레칭"];

  List<Map<String, dynamic>> getFilteredWorkouts() {
    Difficulty selectedDifficulty;
    switch (selectedTab) {
      case 0:
        selectedDifficulty = Difficulty.easy;
        break;
      case 1:
        selectedDifficulty = Difficulty.medium;
        break;
      case 2:
        selectedDifficulty = Difficulty.hard;
        break;
      case 3:
        selectedDifficulty = Difficulty.stretching;
        break;
      default:
        selectedDifficulty = Difficulty.easy;
    }
    return RoutineMockData.workoutData
        .where((routine) => routine.difficulty == selectedDifficulty)
        .map((routine) => routine.toMap())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _workoutBanner(),
              Text("추천 운동 루틴", style: AppTextStyle.subSectionTitle),
              // 🔹 탭 버튼 위젯
              RecommendedWorkoutTabBar(
                tabs: tabs,
                selectedTab: selectedTab,
                onTabSelected: (index) {
                  setState(() {
                    selectedTab = index;
                  });
                },
              ),
              const SizedBox(height: 16),
              // 🔹 운동 루틴 리스트 위젯
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: RecommendedWorkoutList(workouts: getFilteredWorkouts()),
              ),
              // 🔹 더 보기 버튼
              TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("더 보기", style: AppTextStyle.moreButton),
                    SizedBox(
                      width: 5,
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
              Text(
                "운동 기구",
                style: AppTextStyle.subSectionTitle,
              ),
              SizedBox(height: 10),
              _buildSearchBar(),
              SizedBox(height: 10),
              SizedBox(
                height: 300,
                child: equipmentSearchBlock(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _workoutBanner() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.asset(
              "assets/images/workout/stretching.png",
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.secondColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("데일리 운동 루틴", style: AppTextStyle.button),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: '키워드 또는 기구명 검색',
                hintStyle: AppTextStyle.searchHint,
                border: InputBorder.none,
              ),
            ),
          ),
          Assets.icons.search.svg(),
        ],
      ),
    );
  }
}
