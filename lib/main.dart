import 'package:flutter/material.dart';
import 'package:health_routine/presentation/screens/main_screen.dart';

void main() {
  runApp(HR());
}

class HR extends StatelessWidget {
  const HR({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Routine',
      debugShowCheckedModeBanner: false,
      // routerConfig: router,
      home: MainScreen(),
    );
  }
}
