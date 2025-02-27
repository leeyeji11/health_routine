import 'package:flutter/material.dart';
import 'package:health_routine/presentation/widgets/home_screen/recommended_workout_card.dart';

class RecommendedWorkoutList extends StatelessWidget {
  final List<Map<String, dynamic>> workouts;

  const RecommendedWorkoutList({super.key, required this.workouts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return RecommendedWorkoutCard(
          title: workouts[index]["title"]!,
          description: workouts[index]["description"]!,
          image: workouts[index]["image"],
        );
      },
    );
  }
}
