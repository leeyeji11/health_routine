import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_routine/gen/assets.gen.dart';
import 'package:health_routine/presentation/screens/equipment_info_screen.dart';
import 'package:health_routine/presentation/theme/app_color.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';

class MainScreen extends StatefulWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _showEquipmentInfo = false; // 기구 정보 화면 표시 여부

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _showEquipmentInfo = false; // 다른 탭을 누르면 기구 정보 화면 닫기
    });

    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        _navigateToCamera(); // 카메라 이동
        break;
      case 2:
        context.go('/calendar');
        break;
    }
  }

  /// ✅ 카메라에서 촬영 후 돌아올 때 기구 정보 화면을 띄우기
  Future<void> _navigateToCamera() async {
    final scanned = await context.push('/instrument-scan');
    if (scanned == true) {
      setState(() {
        _showEquipmentInfo = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 📌 기구 정보 화면일 때 앱바 숨김
      appBar: _showEquipmentInfo
          ? null
          : AppBar(
              surfaceTintColor: AppColors.white,
              leading: IconButton(
                onPressed: () {
                  context.push('/profile');
                },
                icon: Assets.icons.profile.svg(
                  width: 30,
                  height: 30,
                ),
              ),
              title: Text(
                'Health Routine',
                style: AppTextStyle.appBarHR,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () => context.push('/start'),
                    icon: Icon(Icons.person_2_outlined)),
                IconButton(
                  onPressed: () {
                    context.push('/notification');
                  },
                  icon: Assets.icons.bell.svg(
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
      body: _showEquipmentInfo
          ? EquipmentInfoScreen()
          : widget.child, // 기구 정보 화면 표시 여부
      bottomNavigationBar: _showEquipmentInfo
          ? null // 기구 정보 화면에서는 네비게이션 바 숨김
          : BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Assets.icons.home.svg(width: 30, height: 30),
                  activeIcon:
                      Assets.icons.homeSelected.svg(width: 30, height: 30),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Assets.icons.camera.svg(width: 30, height: 30),
                  activeIcon:
                      Assets.icons.cameraSelected.svg(width: 30, height: 30),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Assets.icons.calendar.svg(width: 30, height: 30),
                  activeIcon:
                      Assets.icons.calendarSelected.svg(width: 30, height: 30),
                  label: '',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
    );
  }
}
