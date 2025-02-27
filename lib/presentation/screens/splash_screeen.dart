import 'package:flutter/material.dart';
import 'package:health_routine/presentation/theme/app_color.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';

class SplashScreeen extends StatelessWidget {
  const SplashScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/splash/hr_splash.png"),
            SizedBox(
              height: 10,
            ),
            Text(
              'Health Routine',
              style: AppTextStyle.splashText,
            )
          ],
        ),
      ),
    );
  }
}
