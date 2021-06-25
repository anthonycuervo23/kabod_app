import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as notifs;
import 'package:rxdart/rxdart.dart' as rxSub;
import 'package:timezone/timezone.dart';

class NotificationClass {
  final int id;
  final String title;
  final String body;
  final String payload;
  NotificationClass({this.id, this.body, this.payload, this.title});
}

final rxSub.BehaviorSubject<NotificationClass>
    didReceiveLocalNotificationSubject =
    rxSub.BehaviorSubject<NotificationClass>();
final rxSub.BehaviorSubject<String> selectNotificationSubject =
    rxSub.BehaviorSubject<String>();

Future<void> initNotifications(
    notifs.FlutterLocalNotificationsPlugin notifsPlugin) async {
  var initializationSettingsAndroid =
      notifs.AndroidInitializationSettings('notification_image');
  var initializationSettingsIOS = notifs.IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(NotificationClass(
            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = notifs.InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await notifsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });
  print("Notifications initialised successfully");
}

void requestIOSPermissions(
    notifs.FlutterLocalNotificationsPlugin notifsPlugin) {
  notifsPlugin
      .resolvePlatformSpecificImplementation<
          notifs.IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}

void removeNotification(
    {notifs.FlutterLocalNotificationsPlugin notifsPlugin, int notificationId}) {
  notifsPlugin.cancel(notificationId);
}

Future<void> scheduleNotification(
    {notifs.FlutterLocalNotificationsPlugin notifsPlugin,
    String id,
    String title,
    String body,
    int notificationId,
    TZDateTime scheduledTime}) async {
  var androidSpecifics = notifs.AndroidNotificationDetails(
    id, // This specifies the ID of the Notification
    'Scheduled notification', // This specifies the name of the notification channel
    'A scheduled notification', //This specifies the description of the channel
    icon: 'notification_image',
  );
  var iOSSpecifics = notifs.IOSNotificationDetails();
  var platformChannelSpecifics =
      notifs.NotificationDetails(android: androidSpecifics, iOS: iOSSpecifics);
  await notifsPlugin.zonedSchedule(
      notificationId, title, body, scheduledTime, platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          notifs.UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true);
}
