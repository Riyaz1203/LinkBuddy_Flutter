import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/spalsh_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:link_buddy/firebase_options.dart';

late Size mq;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
      .then((value) {
    _initializeFirebase();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Link Buddy',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 1,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
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
