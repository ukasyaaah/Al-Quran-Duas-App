import 'package:flutter/material.dart';
import 'package:flutter_alquran/screens/list_quran.dart';
import 'package:flutter_alquran/screens/profile.dart';

import 'package:flutter_alquran/screens/splash_screen.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/main': (context) => MainScreen(),
        '/listquran': (context) => SurahListScreen(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
