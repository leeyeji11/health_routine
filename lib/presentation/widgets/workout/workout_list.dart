import 'package:flutter/material.dart';
import 'package:health_routine/presentation/widgets/workout/workout_card.dart';

class WorkoutList extends StatelessWidget {
  final List<Map<String, dynamic>> workouts;

  const WorkoutList({super.key, required this.workouts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        return WorkoutCard(
          title: workouts[index]["title"]!,
          description: workouts[index]["description"]!,
          image: workouts[index]["image"],
        );
      },
    );
  }
}
