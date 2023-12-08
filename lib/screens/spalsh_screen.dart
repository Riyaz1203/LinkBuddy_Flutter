import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link_buddy/main.dart';
import 'package:link_buddy/screens/auth/login_screen.dart';

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
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Stack(children: [
        Positioned(
            top: mq.height * .30,
            left: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset('images/LinkBuddy.png')),
        Positioned(
            bottom: mq.height * .30,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .06,
            child: const Center(
                child: Text(
              'CRAFTED BY CRAYONT',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: Color.fromARGB(255, 0, 0, 0)),
            )))
      ]),
    );
  }
}
