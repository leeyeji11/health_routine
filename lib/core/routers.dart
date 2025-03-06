import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_routine/presentation/pages/sign_in_page.dart';
import 'package:health_routine/presentation/pages/sign_up_page.dart';
import 'package:health_routine/presentation/pages/start_page.dart';
import 'package:health_routine/presentation/screens/bookmark_screen.dart';
import 'package:health_routine/presentation/screens/calendar_screen.dart';
import 'package:health_routine/presentation/screens/equipment_info_screen.dart';
import 'package:health_routine/presentation/screens/home_screen.dart';
import 'package:health_routine/presentation/screens/instrument_scan_screen.dart';
import 'package:health_routine/presentation/screens/main_screen.dart';
import 'package:health_routine/presentation/screens/notification_list_screen.dart';
import 'package:health_routine/presentation/screens/plan_form_edit_screen.dart';
import 'package:health_routine/presentation/screens/profile_screen.dart';

GoRouter get router => _router;
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey, // ✅ 최상위 Navigator 사용
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey, // ✅ ShellRoute에도 navigatorKey 설정
      builder: (context, state, child) {
        return MainScreen(child: child); // BottomNavigationBar 포함
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: '/calendar',
          builder: (context, state) => CalendarScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/instrument-scan',
      parentNavigatorKey: _rootNavigatorKey, // ✅ 최상위 Navigator에서 실행
      builder: (context, state) => const InstrumentScanScreen(),
    ),
    GoRoute(
      path: '/plan-form-edit',
      builder: (context, state) => PlanFormEditScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      path: '/notification',
      builder: (context, state) => NotificationListScreen(),
    ),
    GoRoute(
      path: '/start',
      builder: (context, state) => StartPage(),
    ),
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => SignInPage(),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => SignUpPage(),
    ),
    GoRoute(
      path: '/equipment-info',
      builder: (context, state) {
       final imagePath = state.extra is String ? state.extra as String : '';
        return EquipmentInfoScreen(imagePath: imagePath);
      },
    ),
    GoRoute(
      path: '/bookmark',
      builder: (context, state) => BookmarkScreen(),
    ),
  ],
);
