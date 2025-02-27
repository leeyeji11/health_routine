import 'package:flutter/material.dart';
import 'package:health_routine/data/routine_mock_data.dart';
import 'package:health_routine/domain/entities/routine.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';
import 'package:health_routine/presentation/widgets/workout/workout_tab_bar.dart';
import 'package:health_routine/presentation/widgets/workout/workout_list.dart';

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
      appBar: AppBar(
        title: Text("추천 운동 루틴", style: AppTextStyle.subSectionTitle),
        elevation: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 탭 버튼 위젯
            WorkoutTabBar(
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
            Expanded(
              child: WorkoutList(workouts: getFilteredWorkouts()),
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
          ],
        ),
      ),
    );
  }
}
