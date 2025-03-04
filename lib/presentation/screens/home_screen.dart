import 'package:flutter/material.dart';
import 'package:health_routine/data/rec_routine_mock.dart';
import 'package:health_routine/domain/entities/routine.dart';
import 'package:health_routine/gen/assets.gen.dart';
import 'package:health_routine/presentation/theme/app_color.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';
import 'package:health_routine/presentation/widgets/home_screen/equipment_search_block.dart';
import 'package:health_routine/presentation/widgets/home_screen/rec_workout_tab_block.dart';
import 'package:health_routine/presentation/widgets/home_screen/rec_workout_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WorkoutBannerBlock(), // 🏋️‍♂️ 운동 배너 블록
            SizedBox(height: 15),
            RecWorkoutBlock(), // 🏋️‍♀️ 추천 운동 루틴 블록
            SizedBox(height: 15),
            EquipmentSearchBlockWidget(), // 🔍 운동 기구 서치 블록
          ],
        ),
      ),
    );
  }
}

// 📌 운동 배너 블록
class WorkoutBannerBlock extends StatelessWidget {
  const WorkoutBannerBlock({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: Text("데일리 운동 루틴", style: AppTextStyle.buttonText),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// 📌 추천 운동 루틴 블록
class RecWorkoutBlock extends StatefulWidget {
  const RecWorkoutBlock({super.key});

  @override
  State<RecWorkoutBlock> createState() => _RecWorkoutBlockState();
}

class _RecWorkoutBlockState extends State<RecWorkoutBlock> {
  int selectedTab = 0;
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
    return RecRoutineMock.recRoutineMock
        .where((routine) => routine.difficulty == selectedDifficulty)
        .map((routine) => routine.toMap())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("추천 운동 루틴", style: AppTextStyle.subSectionTitle),
        SizedBox(height: 15),
        RecWorkoutTabBlock(
          tabs: tabs,
          selectedTab: selectedTab,
          onTabSelected: (index) {
            setState(() {
              selectedTab = index;
            });
          },
        ),
        const SizedBox(height: 16),
        RecommendedWorkoutList(
          workouts: getFilteredWorkouts(),
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("더 보기", style: AppTextStyle.moreButton),
              SizedBox(width: 5),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ],
    );
  }
}

// 📌 운동 기구 서치 블록
class EquipmentSearchBlockWidget extends StatelessWidget {
  const EquipmentSearchBlockWidget({super.key});

  Widget _buildSearchBar(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("운동 기구", style: AppTextStyle.subSectionTitle),
        SizedBox(height: 10),
        _buildSearchBar(context),
        SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: equipmentSearchBlock(),
        ),
      ],
    );
  }
}
