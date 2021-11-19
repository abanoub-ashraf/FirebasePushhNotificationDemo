import 'package:firebase_demo/green_page.dart';
import 'package:firebase_demo/home_page.dart';
import 'package:firebase_demo/red_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(        
                primarySwatch: Colors.blue,
            ),
            home: const HomePage(title: 'Flutter Demo Home Page'),
            routes: {
                'red': (_) => const RedPage(),
                'green': (_) => const GreenPage()
            },
        );
    }
}