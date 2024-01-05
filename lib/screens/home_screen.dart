import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  List<ChatUser> _list = [];
  final List<ChatUser> _searchlist = [];
  bool _isSearching = false;
  @override
  void get initState {
    super.initState;
    APIs.getSelfInfo();
    APIs.updateActiveStatus(true);
    SystemChannels.lifecycle.setMessageHandler((message) {
      if (APIs.auth.currentUser != null) {
        if (message.toString().contains('pause'))
          APIs.updateActiveStatus(false);
        if (message.toString().contains('resume'))
          APIs.updateActiveStatus(true);
      }
      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: const Icon(Icons.home),
            title: _isSearching
                ? TextField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name, Email ...',
                        hintStyle: TextStyle(color: Colors.white)),
                    autofocus: true,
                    style: const TextStyle(
                        fontSize: 18, color: Colors.white, letterSpacing: 1),
                    onChanged: (val) {
                      _searchlist.clear();

                      for (var i in _list) {
                        if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                            i.email.toLowerCase().contains(val.toLowerCase())) {
                          _searchlist.add(i);
                        }
                        setState(() {
                          _searchlist;
                        });
                      }
                    },
                  )
                : const Text('LinkBuddy⚡'),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  },
                  icon: Icon(_isSearching
                      ? CupertinoIcons.clear_circled_solid
                      : Icons.search)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProfileScreen(user: APIs.me)));
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
              stream: APIs.getAllUsers(),
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
                    _list = data
                            ?.map((e) => ChatUser.fromJson(e.data()))
                            .toList() ??
                        [];

                    if (_list.isNotEmpty) {
                      return ListView.builder(
                        itemCount:
                            _isSearching ? _searchlist.length : _list.length,
                        itemBuilder: (context, index) {
                          return ChatUserCard(
                              user: _isSearching
                                  ? _searchlist[index]
                                  : _list[index]);
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
        ),
      ),
    );
  }
}
