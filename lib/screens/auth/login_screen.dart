import 'package:flutter/material.dart';
import 'package:link_buddy/main.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  _handleGoogleBtnClick(){

  }

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}



  @override
  Widget build(BuildContext context) {
    // mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Hi Buddy..'),
      ),
      body: Stack(children: [
        Positioned(
            top: mq.height * .20,
            left: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset('images/LinkBuddy.png')),
        Positioned(
            bottom: mq.height * .30,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .06,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(), elevation: 1),
                onPressed: () {},
                icon: Image.asset(
                  'images/google.png',
                  height: mq.height * .03,
                ),
                label: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                        children: [
                      TextSpan(text: 'Login With '),
                      TextSpan(
                          text: 'Google',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                    ]))))
      ]),
    );
  }
}
