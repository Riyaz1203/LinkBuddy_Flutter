// import 'dart:convert';
// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:link_buddy/helper/my_date_util.dart';
import 'package:link_buddy/main.dart';
import 'package:link_buddy/models/chat_user.dart';
import 'package:link_buddy/models/message.dart';
import 'package:link_buddy/screens/view_profile_screen.dart';
import 'package:link_buddy/widgets/message_card.dart';

import '../api/apis.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _list = [];

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: _appbar(),
        ),
        backgroundColor: const Color.fromARGB(255, 234, 248, 255),
        body: Column(children: [
          Expanded(
            child: StreamBuilder(
              stream: APIs.getAllMessages(widget.user),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(
                      child: SizedBox(),
                    );

                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    _list =
                        data?.map((e) => Message.fromJson(e.data())).toList() ??
                            [];

                    if (_list.isNotEmpty) {
                      return ListView.builder(
                        itemCount: _list.length,
                        itemBuilder: (context, index) {
                          return MessageCard(message: _list[index]);
                        },
                      );
                    } else {
                      // Return the Center widget
                      return const Center(
                        child: Text(
                          'Say Hello! 👋✌️',
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }
                }
              },
            ),
          ),
          _chatinput(),
        ]),
      ),
    );
  }

  Widget _chatinput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.width * .01, horizontal: mq.width * .025),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  // IconButton(
                  //     onPressed: () {
                  //       setState(() => _showEmoji = !_showEmoji);
                  //     },
                  //     icon: const Icon(
                  //       Icons.emoji_emotions,
                  //       color: Colors.blue,
                  //     )),
                  Expanded(
                      child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        hintStyle: TextStyle(
                          color: Colors.blue,
                        ),
                        border: InputBorder.none),
                  ))
                ],
              ),
            ),
          ),
          MaterialButton(
            shape: const CircleBorder(),
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
            color: Colors.blue,
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                APIs.sendMessage(widget.user, _textController.text);
                _textController.text = '';
              }
            },
            child: const Icon(
              Icons.send,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          )
        ],
      ),
    );
  }

  Widget _appbar() {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ViewProfileScreen(user: widget.user))); 
        },
        child: Center(
          child: StreamBuilder(
              stream: APIs.getUserInfo(widget.user),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final list =
                    data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                        [];

                return Row(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                    CircleAvatar(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(widget.user.image),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          list.isNotEmpty ? list[0].name : widget.user.name,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          list.isNotEmpty
                              ? list[0].isOnline
                                  ? 'Online'
                                  : myDateUtil.getLastActiveTime(
                                      context: context,
                                      lastActive: list[0].lastActive)
                              : myDateUtil.getLastActiveTime(
                                  context: context,
                                  lastActive: widget.user.lastActive),
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        )
                      ],
                    )
                  ],
                );
              }),
        ));
  }
}
