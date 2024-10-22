import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

@pragma('vm:entry-point') // 이 라인 추가
Future<void> notificationBackgroundHandler(NotificationResponse response) async {
  // 백그라운드에서 알림 처리 로직
  if (response.payload != null) {
    print('notification payload: ${response.payload}');
  }
}

class LocalNotificationService {
  static final LocalNotificationService _instance = LocalNotificationService._();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // set Android settings
    const AndroidInitializationSettings androidInitializationSetting =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // set iOS settings
    const DarwinInitializationSettings iOsInitializationSettings =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );

    // set initialization settings
    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSetting,
      iOS: iOsInitializationSettings,
    );

    // initialize plugin
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: notificationBackgroundHandler,
      onDidReceiveBackgroundNotificationResponse: notificationBackgroundHandler, // 동일한 핸들러 사용
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation
    <AndroidFlutterLocalNotificationsPlugin>()
    ?.createNotificationChannel(const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
    ));

    // initialized timezone
    tz.initializeTimeZones();
  }

  // permission check for IOS
  Future<void> requestIOSPermissions() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation
    <IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  // directly show notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          channelDescription: 'channel_description',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(badgeNumber: 1),
    );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // schedule notification
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'channel_id',
            'channel_name',
            channelDescription: 'channel_description',
            importance: Importance.max,
            priority: Priority.high,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(badgeNumber: 1),
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    payload: payload,
    );
  }

  // periodic notification
  Future<void> periodicallyShowNotification({
    required int id,
    required String title,
    required String body,
    required RepeatInterval repeatInterval,
    String? payload,
}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          channelDescription: 'channel_description',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(badgeNumber: 1),
    );

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      repeatInterval,
      notificationDetails,
      payload: payload,
    );
  }

  // click notification event
  void onDidReceiveNotificationResponse(NotificationResponse response) {
    // 페이로드 처리
    if (response.payload != null) {
      print('notification payload: ${response.payload}');
    }
    // 원하는 작업 수행
  }

  // cancel all of notifications
  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  // cancel notification by id
  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

}