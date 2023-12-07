import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Link Buddy',
      theme: ThemeData(
          primarySwatch: Colors.orange,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 1,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
          )),
      home: const HomeScreen(),
    );
  }
}
