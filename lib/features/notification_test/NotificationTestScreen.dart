import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:skeleton/core/local_notification/LocalNotification.dart';

class NotificationTestScreen extends StatelessWidget {
  static const String name = 'NotificationTestScreen';
  final notificationService = LocalNotificationService();
  NotificationTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Test'),
      ),
      body: Column(
        children: [
          TextButton(onPressed: (){
            notificationService.showNotification(
                id: 0,
                title: '즉시 알림',
                body: '즉시 알림 테스트 입니다.',
                payload: 'payload'
            );
          },
              child: const Text('즉시 알림 테스트')),
          TextButton(onPressed: (){
            final scheduledDate = DateTime.now().add(const Duration(seconds: 5));
            notificationService.scheduleNotification(
                id: 1,
                title: '예약알림 알림',
                body: '즉시 알림 테스트 입니다.',
                scheduledDate: scheduledDate,
                payload: 'payload'
            );
          },
              child: const Text('예약알림테스트 ')),
          TextButton(onPressed: (){
            final scheduledDate = DateTime.now().add(const Duration(seconds: 5));
            notificationService.periodicallyShowNotification(
                id: 1,
                title: '주기적 알림',
                body: '매시산 알림 테스트 입니다.',
                repeatInterval: RepeatInterval.hourly,
                payload: 'payload'
            );
          },
              child: const Text('매 시간 알림 테스트')),
          ElevatedButton(
            onPressed: () {
              notificationService.cancelAllNotifications();
            },
            child: Text('모든 알림 취소'),
          ),
        ],
      ),
    );
  }
}
