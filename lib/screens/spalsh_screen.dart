import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link_buddy/api/apis.dart';
import 'package:link_buddy/main.dart';
import 'dart:developer';
import 'package:link_buddy/screens/auth/login_screen.dart';
import 'package:link_buddy/screens/home_screen.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void get initState {
    super.initState;
    Future.delayed(const Duration(milliseconds: 2000), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(0, 255, 255, 255),
          systemNavigationBarColor: Colors.white));
      if (APIs.auth.currentUser != null) {
        log('User :${APIs.auth.currentUser}');

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return const Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Stack(children: [
          Center(
              child: Text(
            'LINKBUDDY ⚡',
            style: TextStyle(
                fontSize: 20,
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255)),
          ))
        ]),
      ),
    );
  }
}
