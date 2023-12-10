import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:link_buddy/helper/dialouge.dart';
import 'package:link_buddy/main.dart';
import 'package:link_buddy/models/chat_user.dart';
import 'package:link_buddy/screens/auth/login_screen.dart';

import '../api/apis.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile Screen'),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            onPressed: () async {
              Dialouge.showProgressBar(context);

              await APIs.auth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) {
                  Navigator.pop(context);
                  Navigator.pop(context);

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                });
              });
            },
            icon: const Icon(Icons.logout),
            label: Text('Log Out'),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
          child: Column(
            children: [
              SizedBox(
                width: mq.width,
                height: mq.height * .05,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 0.1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        widget.user.image,
                        height: MediaQuery.of(context).size.height * 0.2,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: MaterialButton(
                      onPressed: () {},
                      color: Colors.white,
                      shape: CircleBorder(),
                      elevation: 1,
                      child: Icon(
                        Icons.edit,
                        color: Colors.blueAccent,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Text(
                widget.user.email,
                style: const TextStyle(color: Colors.blue),
              ),
              SizedBox(
                height: mq.height * .04,
              ),
              TextFormField(
                initialValue: widget.user.name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.blueAccent,
                    ),
                    hintText: 'Eg : Riyaz',
                    label: const Text(
                      'Name',
                      style: TextStyle(color: Colors.blue),
                    )),
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              TextFormField(
                initialValue: widget.user.about,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    prefixIcon:
                        const Icon(Icons.hiking, color: Colors.blueAccent),
                    hintText: 'Eg : Have a Smile',
                    label: const Text(
                      'About',
                      style: TextStyle(color: Colors.blue),
                    )),
              ),
              SizedBox(
                height: mq.height * .05,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      minimumSize: Size(mq.width * .4, mq.height * .055)),
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                  label: Text('Update')),
            ],
          ),
        ));
  }
}
