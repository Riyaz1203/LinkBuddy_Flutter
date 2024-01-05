import 'package:flutter/material.dart';
import 'package:link_buddy/api/apis.dart';
import 'package:link_buddy/helper/my_date_util.dart';
import 'package:link_buddy/models/chat_user.dart';
import 'package:link_buddy/models/message.dart';

import '../screens/chat_screen.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  Message? _message;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreen(user: widget.user)));
          },
          child: StreamBuilder(
            stream: APIs.getLastMessage(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
              if (list.isNotEmpty) {
                _message = list[0];
              }
              return ListTile(
                  leading: CircleAvatar(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(widget.user.image),
                    ),
                  ),
                  title: Text(widget.user.name),
                  subtitle: Text(
                    _message != null ? _message!.msg : widget.user.about,
                    maxLines: 1,
                  ),
                  trailing: _message == null
                      ? null
                      : _message!.read.isEmpty &&
                              _message!.fromid != APIs.user.uid
                          ? Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 169, 87),
                                  borderRadius: BorderRadius.circular(10)),
                            )
                          : Text(myDateUtil.getLastMessageTime(
                              context: context, time: _message!.sent)));
            },
          )),
    );
  }
}
