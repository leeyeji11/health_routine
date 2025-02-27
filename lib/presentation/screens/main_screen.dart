import 'package:flutter/material.dart';
import 'package:health_routine/gen/assets.gen.dart';
import 'package:health_routine/presentation/screens/calender_screen.dart';
import 'package:health_routine/presentation/screens/home_screen.dart';
import 'package:health_routine/presentation/screens/instrument_scan_screen.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    HomeScreen(),
    InstrumentScanScreen(),
    CalenderScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Assets.icons.profile.svg(
            width: 30,
            height: 30,
          ),
        ),
        title: Text(
          'Health Routine',
          style: AppTextStyle.appBarTitle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Assets.icons.bell.svg(
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Assets.icons.home.svg(
              width: 30,
              height: 30,
            ),
            activeIcon: Assets.icons.homeSelected.svg(
              width: 30,
              height: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.camera.svg(
              width: 30,
              height: 30,
            ),
            activeIcon: Assets.icons.cameraSelected.svg(
              width: 30,
              height: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.calendar.svg(
              width: 30,
              height: 30,
            ),
            activeIcon: Assets.icons.calendarSelected.svg(
              width: 30,
              height: 30,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
