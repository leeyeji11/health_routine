import 'package:flutter/material.dart';
import 'package:health_routine/presentation/widgets/home_screen/rec_workout_card.dart';

class RecommendedWorkoutList extends StatelessWidget {
  final List<Map<String, dynamic>> workouts;

  const RecommendedWorkoutList({super.key, required this.workouts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return RecWorkoutCard(
          title: workouts[index]["title"]!,
          description: workouts[index]["description"]!,
          time: workouts[index]["time"]!.toString(),
          image: workouts[index]["image"],
        );
      },
    );
  }
}
