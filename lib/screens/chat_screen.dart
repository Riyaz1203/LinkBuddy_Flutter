import 'package:flutter/material.dart';
import 'package:link_buddy/main.dart';
import 'package:link_buddy/models/chat_user.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: _appbar(),
        ),
        body: Column(children: [
          Expanded(
            child: StreamBuilder(
              // stream: APIs.getAllUsers(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                  // return const Center(
                  //   child: CircularProgressIndicator(),
                  // );

                  case ConnectionState.active:
                  case ConnectionState.done:
                    // final data = snapshot.data?.docs;
                    // _list = data
                    //         ?.map((e) => ChatUser.fromJson(e.data()))
                    //         .toList() ??
                    //     [];

                    final _list = [];

                    if (_list.isNotEmpty) {
                      return ListView.builder(
                        itemCount: _list.length,
                        itemBuilder: (context, index) {
                          return Text('Hello');
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
              stream: null,
            ),
          ),
          _chatinput()
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
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Colors.blue,
                      )),
                  const Expanded(
                      child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
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
            onPressed: () {},
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
      onTap: () {},
      child: Center(
        child: Row(
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
                  widget.user.name,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Text(
                  'last seen not available',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
