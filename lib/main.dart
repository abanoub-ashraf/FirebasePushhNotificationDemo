import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/my_app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

///
/// receive a message when the app is in the background
///
Future<void> backgroundHandler(RemoteMessage message) async {
    print(message.data.toString());
    print(message.notification!.title);
}

void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

    ///
    /// handle the notifications that comes when the app is in the background
    ///
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    runApp(
        const MyApp()
    );
}