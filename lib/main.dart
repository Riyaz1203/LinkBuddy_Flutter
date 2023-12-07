import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';

late Size mq;


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
      home: const LoginScreen(),
    );
  }
}
