import 'package:flutter/material.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "알림 목록",
          style: AppTextStyle.appBarTitle,
        ),
      ),
      body: Column(
        children: [Text('Notification List Screen')],
      ),
    );
  }
}
