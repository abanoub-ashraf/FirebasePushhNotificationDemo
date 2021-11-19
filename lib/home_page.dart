import 'package:firebase_demo/services/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
    final String title;

    const HomePage({Key? key, required this.title}) : super(key: key);

    @override
    State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    @override
    void initState() {
        super.initState();

        LocalNotificationService.initialize(context);

        ///
        /// - when the user receive a notification while the app is terminated
        ///   this acts on the user tapping on that notification
        ///
        /// - this gives you the message on which user taps and it opened
        ///   the app from terminated state
        ///
        FirebaseMessaging.instance.getInitialMessage().then((message) {
            if (message != null) {
                final routeFromMessage = message.data['route'];

                Navigator.of(context).pushNamed(routeFromMessage);
            }
        });

        ///
        /// - this works only when the app is in the foreground
        /// 
        /// - when the app is in foreground the app doesn't display a head notification
        /// 
        /// - when the app is in foreground firebase never displays the notification on the screen
        /// 
        /// - it doesn't show a head notification on the screen so we need this display() function
        ///
        FirebaseMessaging.onMessage.listen((message) {
            if (message.notification != null) {
                print(message.notification!.body);
                print(message.notification!.title);

                ///
                /// - if we wanna firebase to display a hed notification on the screen
                ///   we need to create a notification channel in the android manifest file
                ///   and also create one using flutter local notification package
                /// 
                /// - if we wanna do something when the user tap on a notification they received
                ///   on the foreground we need to implement that action inside the local notification
                ///   service class not using firebase itself
                ///
                LocalNotificationService.display(message);
            }
        });

        ///
        /// - this gets fired when the user taps on a notification to open it
        /// 
        /// - this works when the app is on the background but opened and the user taps
        ///   on the notification to open it  
        ///
        FirebaseMessaging.onMessageOpenedApp.listen((message) {
            final routeFromMessage = message.data['route'];

            Navigator.of(context).pushNamed(routeFromMessage);
        });
    }

    @override
    Widget build(BuildContext context) {
        return const Scaffold(
            body: Padding(
                padding: EdgeInsets.all(18.0),
                child: Center(
                    child: Text(
                        'You will receive message soon',
                        style: TextStyle(fontSize: 34),
                    ),
                ),
            ),
        );
    }
}