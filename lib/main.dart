import 'package:flutter/material.dart';
import 'package:health_routine/core/routers.dart';
import 'package:health_routine/presentation/theme/app_color.dart';

void main() {
  runApp(HR());
}

class HR extends StatelessWidget {
  const HR({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      color: AppColors.white,
      title: 'Health Routine',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
