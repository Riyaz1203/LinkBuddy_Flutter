import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:link_buddy/models/chat_user.dart';
import 'package:link_buddy/screens/profile_screen.dart';
import 'package:link_buddy/widgets/chat_user_card.dart';

import '../api/apis.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        title: const Text('Link Buddy'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProfileScreen(user: list[2])));
              },
              icon: const Icon(Icons.more_vert)),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
          onPressed: () async {
            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: StreamBuilder(
          stream: APIs.firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                    [];

                if (list.isNotEmpty) {
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return ChatUserCard(user: list[index]);
                    },
                  );
                } else {
                  // Return the Center widget
                  return const Center(
                    child: Text(
                      'No Connections Found',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
            }
          }),
    );
  }
}
