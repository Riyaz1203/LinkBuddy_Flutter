import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link_buddy/main.dart';
import 'package:link_buddy/models/chat_user.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: InkWell(
        onTap: () {},
        child: ListTile(
            leading: const CircleAvatar(
              child: Icon(CupertinoIcons.person),
            ),
            title: Text(widget.user.name),
            subtitle: Text(
              widget.user.about,
              maxLines: 1,
            ),
            trailing: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: Colors.greenAccent.shade400,
                  borderRadius: BorderRadius.circular(10)),
            )),
      ),
    );
  }
}