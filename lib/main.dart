import 'package:flutter/material.dart';
import 'screens/spalsh_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:link_buddy/firebase_options.dart';

late Size mq;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initializeFirebase();
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
      home: const SpalshScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
