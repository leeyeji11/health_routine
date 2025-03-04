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

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainScreen(child: child); // BottomNavigationBar 포함
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: '/instrument-scan',
          builder: (context, state) => InstrumentScanScreen(),
        ),
        GoRoute(
          path: '/calendar',
          builder: (context, state) => CalendarScreen(),
        ),
      ],
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
      builder: (context, state) => EquipmentInfoScreen(),
    ),
    GoRoute(
      path: '/bookmark',
      builder: (context, state) => BookmarkScreen(),
    ),
  ],
);
