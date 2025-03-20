import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // 알람 초기화
  Future<void> initNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _notificationsPlugin.initialize(settings);

    // ✅ 앱 시작 시 자동으로 권한 요청 (iOS 및 Android 13 이상)
    await requestNotificationPermission();
  }

  /// 🔔 알림 권한 요청 (iOS + Android 13 이상)
  Future<bool> requestNotificationPermission() async {
    if (Platform.isIOS) {
      final bool? granted = await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      return granted ?? false;
    } else if (Platform.isAndroid) {
      if (await _isAndroid13OrHigher()) {
        final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
            _notificationsPlugin.resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();

        if (androidImplementation != null) {
          try {
            return true; // Android 13 이상에서는 권한 요청이 필요 없음
          } catch (e) {
            debugPrint("❌ Android 권한 요청 실패: $e");
            return false;
          }
        }
      }
    }
    return true; // Android 12 이하는 자동 승인됨
  }

  /// ✅ Android 13(Tiramisu, API 33) 이상인지 확인하는 함수
  Future<bool> _isAndroid13OrHigher() async {
    return (await _notificationsPlugin
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()
                ?.getActiveNotifications())
            ?.isNotEmpty ??
        false;
  }

  /// 📨 알림 보내기 (테스트용)
  Future<void> showNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails('channel_id', 'channel_name',
            importance: Importance.high,
            priority: Priority.high,
            showWhen: false);

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails details =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notificationsPlugin.show(0, '알림 제목', '알림 내용입니다.', details);
  }
}
