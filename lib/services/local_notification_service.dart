import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
    static final FlutterLocalNotificationsPlugin _notificationPlugin = FlutterLocalNotificationsPlugin();

    static void initialize(BuildContext context) {
        const androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

        const InitializationSettings initializationSettings = InitializationSettings(
            android: androidInitializationSettings,
        );

        _notificationPlugin.initialize(
            initializationSettings, 
            onSelectNotification: (String? payload) async {
                if (payload != null) {
                    Navigator.of(context).pushNamed(payload);
                }
            }
        );
    }

    ///
    /// this will create the notification channel we need in order for the app to display
    /// the notification on the screen in the head notification
    ///
    static void display(RemoteMessage message) async {
        try {
            final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

            ///
            /// - this channel is the same one we added in the manifest file in the android manifest
            /// 
            /// - it should have the same channel id as in the manifest file
            ///
            const androidNotificationDetails = AndroidNotificationDetails(
                'pushnotificationtutorial', 
                'pushnotificationtutorial channel',
                channelDescription: 'this is our push notification tutorial',
                importance: Importance.max,
                priority: Priority.high
            );

            const NotificationDetails notificationDetails = NotificationDetails(
                android: androidNotificationDetails
            );

            await _notificationPlugin.show(
                id, 
                message.notification!.title, 
                message.notification!.body,
                notificationDetails,
                payload: message.data['route']
            );
        } on Exception catch (exception) {
            print(exception);
        }
    }
}