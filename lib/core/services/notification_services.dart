import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await _notifications
    .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
    ?.requestNotificationsPermission();
    await _notifications.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
  }

  static Future<void> showReminder() async {
    await _notifications.show(
      id: 1,
      title: 'Time to Stretch',
      body: 'You have been inactive for a while.',
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'stretch_reminder',
          'Stretch Reminder',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
}
